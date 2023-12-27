import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_assignment/model/databse_helper2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ViewNewUserData extends StatefulWidget {
  const ViewNewUserData({super.key});

  @override
  State<ViewNewUserData> createState() => _ViewNewUserDataState();
}

class _ViewNewUserDataState extends State<ViewNewUserData> {

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updateAddressController = TextEditingController();
  var updateImage;


  List<Map<String, dynamic>> viewNewUserDataList = [];
  bool isLoading = true;

  void _refreshNewUserData() async {
    final data = await UserDataBaseHelper.instance.viewNewUserData();
    setState(() {
      viewNewUserDataList = data ?? [];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNewUserData();
  }

  Future<void>  _showAlertDialog(int? id) async {
    if (id != null) {
      final existingUserData = viewNewUserDataList.firstWhere((element) => element['id'] == id);
      updateImage = existingUserData['image'];
      updateNameController.text = existingUserData['name'].toString();
      updateEmailController.text = existingUserData['email'].toString();
      updateAddressController.text = existingUserData['address'].toString();
    }

    return showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: Text("Update User Data"),
        content: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _getImage();
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Image.file(File(updateImage)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: updateNameController,
                decoration: InputDecoration(
                  hintText: 'Name'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: updateEmailController,
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: updateAddressController,
                decoration: InputDecoration(
                    hintText: 'Address'
                ),
              ),
            )

          ],
        ),

        actions: <Widget>[
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Cancel")),

          TextButton(onPressed: () async {
            await _updateNewUserData(id);
            updateNameController.text = '';
            updateEmailController.text = '';
            updateAddressController.text = '';
            // updateImage = null;
            _image = null;

            Navigator.pop(context);
          }, child: Text("Update"))
        ],
      );
    },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "View New UserData",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: viewNewUserDataList.length,
            itemBuilder: (context, index) {

              final id = viewNewUserDataList[index]['id'].toString();
              final name = viewNewUserDataList[index]['name']as String?;
              final email = viewNewUserDataList[index]['email']as String?;
              final address = viewNewUserDataList[index]['address']as String?;
              final image = viewNewUserDataList[index]['image'] as String?;

              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: image != null
                          ? Image.file(File(image))
                          : Icon(Icons.image)
                    ),
                    title: Text(name ?? 'No Name'),
                    subtitle: Text(email ?? "No Email"),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: () {
                            
                            _showAlertDialog(
                                int.parse(id),
                            );
                            
                          }, icon: Icon(Icons.edit, color: Colors.blue,)),

                          IconButton(onPressed: () {
                            _deleteNewUserData(int.parse(id));
                          }, icon: Icon(Icons.delete, color: Colors.red,))
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },),
    );
  }

  Future<void> _updateNewUserData(int? id) async {
    if(_image != null) {
      final appDirectory = await getApplicationDocumentsDirectory();
      final imagePath = '${appDirectory.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
      await _image!.copy(imagePath);

      await UserDataBaseHelper.instance.updateNewUserData({
        UserDataBaseHelper.newUserId : id,
        UserDataBaseHelper.newUserName : updateNameController.text,
        UserDataBaseHelper.newUserEmail : updateEmailController.text,
        UserDataBaseHelper.newUserAddress : updateAddressController.text,
        UserDataBaseHelper.newUserImage : imagePath
      });

    }

    _refreshNewUserData();
  }

  Future<void> _deleteNewUserData(int id) async {
  await  UserDataBaseHelper.instance.deleteNewUserData(id);
    _refreshNewUserData();
  }

}
