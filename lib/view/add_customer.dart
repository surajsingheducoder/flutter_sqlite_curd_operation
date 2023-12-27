import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_assignment/model/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';


class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future pickGalleryImage() async {
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

  // String? selectedGender;
  // var genders = ['Male', 'Female', 'Other'];

  List<String> selectedHabits = [];

  List<String> allHabits = [
    'Reading',
    'Writing',
    'Playing',
    'Binge watching',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Add Customer",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          
          InkWell(
            onTap: () {
              pickGalleryImage();
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green,width: 2)
              ),
              child: _image != null
                  ? Image.file(_image!.absolute, fit: BoxFit.cover,)
                  : Center(child: Text("Select Image"))
            ),
          ),
          
          const SizedBox(height: 10),
          const Text(
            'Name*',
            style: TextStyle(color: Colors.green, fontSize: 18),
          ),
          SizedBox(
            height: 65,
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              cursorColor: Colors.green,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Enter your name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2)
                ),
                iconColor: Colors.green,
                hintStyle: TextStyle(color: Colors.lightGreen, fontSize: 15),
                prefixIconColor: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Email*',
            style: TextStyle(color: Colors.green, fontSize: 18),
          ),
          SizedBox(
            height: 65,
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.green,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Enter your email",
                border: OutlineInputBorder(
                  borderSide: BorderSide( color: Colors.green, width: 2)
                ),
                iconColor: Colors.white,
                hintStyle: TextStyle(color: Colors.lightGreen, fontSize: 15),
                prefixIconColor: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // const Text(
          //   'Gender*',
          //   style: TextStyle(color: Colors.green, fontSize: 18),
          // ),
          // SizedBox(
          //   height: 65,
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     color: Colors.green,
          //     shadowColor: Colors.black,
          //     elevation: 5,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: DropdownButton(
          //         isExpanded: true,
          //         alignment: Alignment.bottomLeft,
          //         value: selectedGender,
          //         underline: Container(),
          //         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
          //         dropdownColor: Colors.green,
          //         items: genders.map((item) {
          //           return DropdownMenuItem(
          //             value: item,
          //             child: Text(item),
          //           );
          //         }).toList(),
          //         hint: const Text("Select Gender",
          //           style: TextStyle(color: Colors.white),),
          //         onChanged: (value) {
          //           setState(() {
          //             selectedGender = value.toString();
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          // const Text(
          //   'Habit*',
          //   style: TextStyle(color: Colors.green, fontSize: 18),
          // ),
          // SizedBox(
          //   child: Wrap(
          //     spacing: 8.0,
          //     children: allHabits.map((habit) {
          //       return ChoiceChip(
          //         checkmarkColor: Colors.green,
          //         label: Text(habit),
          //         selected: selectedHabits.contains(habit),
          //         onSelected: (selected) {
          //           setState(() {
          //             if (selected) {
          //               selectedHabits.add(habit);
          //             } else {
          //               selectedHabits.remove(habit);
          //             }
          //           });
          //         },
          //       );
          //     }).toList(),
          //   )
          // ),

          const SizedBox(height: 15),
          const Text(
            'Address*',
            style: TextStyle(color: Colors.green, fontSize: 18),
          ),
          SizedBox(
            height: 65,
            child: TextField(
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              cursorColor: Colors.green,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                hintText: "Enter your address",
                border: OutlineInputBorder(
                borderSide: BorderSide( color: Colors.green, width: 2)),
                hintStyle: TextStyle(color: Colors.lightGreen, fontSize: 15),
                prefixIconColor: Colors.green,
              ),
            ),
          ),

         const SizedBox(height: 20,),

          Center(
            child: SizedBox(
              height: 55,
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder()),
                  onPressed: () async {
                    if(_image != null){
                      final appDirectory = await getApplicationDocumentsDirectory();
                      final imagePath =  '${appDirectory.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
                      print('Image Path: $imagePath');
                      await _image!.copy(imagePath);

                        await DatabaseHelper.instance.insertUserRecord({
                          DatabaseHelper.userName: nameController.text,
                          DatabaseHelper.userImagePath: imagePath,
                          DatabaseHelper.userEmail: emailController.text,
                          DatabaseHelper.userAddress: addressController.text,
                        });

                      Fluttertoast.showToast(msg: "Data insert");
                      Navigator.pop(context);
                    }
                    else{
                      Fluttertoast.showToast(msg: "Data couldn't insert");
                    }

                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),
        ],
      ),
    );
  }

}
