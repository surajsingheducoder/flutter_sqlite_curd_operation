import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_assignment/model/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {

  final TextEditingController updateNameController = TextEditingController();
  final TextEditingController updateEmailController = TextEditingController();
  final TextEditingController updateAddressController = TextEditingController();
  var updatePic;


  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future pickUserImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  List<Map<String, dynamic>> viewUserDataList = [];
  bool isLoading = true;

  Future<void> _refreshData() async {
    viewUserDataList.clear(); // clear old data
    final data = await DatabaseHelper.instance.viewUserData();
    setState(() {
      viewUserDataList.addAll(data??[]); // add updated data
      isLoading = false;
    });
  }



  @override
  void initState() {
    super.initState();
      _refreshData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "View Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: viewUserDataList.length,
        itemBuilder: (context, index) {
          final id = viewUserDataList[index]['id'].toString();
          final imagePath = viewUserDataList[index]['pic'] as String;
          final name = viewUserDataList[index]['name'] as String;
          final email = viewUserDataList[index]['email'] as String;
          final address = viewUserDataList[index]['address'] as String;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    child: imagePath != null
                        ? Image.file(File(imagePath))
                        :Icon(Icons.person)
                  ),
                  title: Text(name ?? 'No Name'),
                  subtitle: Text(email ?? "No Email"),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [

                        Expanded(
                          child: IconButton(onPressed: () {
                            var itemId =int.parse(viewUserDataList[index]['id'].toString());
                            print(itemId);
                              _showFrom(itemId);
                          }, icon: Icon(Icons.edit, color: Colors.blue, size: 30,)),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: IconButton(onPressed: () {
                            _deleteUserData(int.parse(id));
                          }, icon: Icon(Icons.delete, color: Colors.red, size: 30,)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
      },),
    );
  }

  void _showFrom(int? id) async {
    if (id != null) {
      final existingUserData = viewUserDataList.firstWhere((element) => element['id'] == id);
      updatePic = existingUserData['pic'];
      updateNameController.text = existingUserData['name'].toString();
      updateEmailController.text = existingUserData['email'].toString();
      updateAddressController.text = existingUserData['address'].toString();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    pickUserImage();
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Image.file(File(updatePic)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: updateNameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: updateEmailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: updateAddressController,
                    decoration: InputDecoration(
                      hintText: "Address",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await _updateUserData(id);
                      updateNameController.text = '';
                      updateEmailController.text = '';
                      updateAddressController.text = '';
                      updatePic = null;
                      _image = null;
                      Navigator.pop(context);
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _updateUserData(int? id) async {
    if(_image != null){
      final appDir = await getApplicationDocumentsDirectory();
      final imagePath = '${appDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
      await _image!.copy(imagePath);

      await DatabaseHelper.instance.updateUserData({
        DatabaseHelper.userId : id,
        DatabaseHelper.userName : updateNameController.text,
        DatabaseHelper.userEmail : updateEmailController.text,
        DatabaseHelper.userAddress : updateAddressController.text,
        DatabaseHelper.userImagePath : imagePath
      });
    };
    _refreshData();

  }

  Future<void> _deleteUserData(int id) async {
    await DatabaseHelper.instance.deleteUserData(id);
    _refreshData();
  }

}
