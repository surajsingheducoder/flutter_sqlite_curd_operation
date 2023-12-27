import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_assignment/model/databse_helper2.dart';
import 'package:path_provider/path_provider.dart';

class InsertNewUser extends StatefulWidget {
  const InsertNewUser({super.key});

  @override
  State<InsertNewUser> createState() => _InsertNewUserState();
}

class _InsertNewUserState extends State<InsertNewUser> {


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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Insert User Data", style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                _getImage();
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                child: _image != null
                    ? Image.file(_image!.absolute, fit: BoxFit.cover,)
                    : Icon(Icons.image, size: 100)
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name"
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                      hintText: "Address"
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                    onPressed: () async {
                      if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && addressController.text.isNotEmpty && _image != null){
                        final appDirectory = await getApplicationDocumentsDirectory();
                        final imagePath = '${appDirectory.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
                        await _image!.copy(imagePath);

                        await UserDataBaseHelper.instance.insertData({
                          UserDataBaseHelper.newUserName: nameController.text,
                          UserDataBaseHelper.newUserEmail: emailController.text,
                          UserDataBaseHelper.newUserAddress: addressController.text,
                          UserDataBaseHelper.newUserImage : imagePath,
                        });
                        Fluttertoast.showToast(msg: "Insert Successful");
                        Navigator.pop(context);
                      }
                      else{
                        Fluttertoast.showToast(msg: "Please fill all data");
                      }

                }, child: Text("Submit"))


              ],
            ),
          )
        ],
      ),
    );
  }
}
