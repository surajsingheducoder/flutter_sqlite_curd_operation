import 'package:flutter/material.dart';
import 'package:new_assignment/model/database_helper.dart';
import 'package:new_assignment/view/insert_new_user.dart';
import 'package:new_assignment/view/insert_video.dart';
import 'package:new_assignment/view/view_data.dart';
import 'package:new_assignment/view/view_newuser_data.dart';

import 'add_customer.dart';
import 'customer_details.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("data",style: TextStyle(color: Colors.white),),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            itemBuilder: (context) =>[
            PopupMenuItem(
              // onTap: () {
              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddCustomer(
              //
              //     ),));
              // },
              value: 1,
              child: const Row(
                children: [
                  Icon(Icons.add,color: Colors.green,),
                  SizedBox( width: 10),
                  Text("Add customer")
                ],
              ),
            ),
          ],)
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCustomer(),));
              },
              child: SizedBox(
                height: 80,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.green,width: 1.5)
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Create", style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewData(),));
              },
              child: SizedBox(
                height: 80,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.green,width: 1.5)
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("View, Update & Delete", style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InsertNewUser(),));
              },
              child: SizedBox(
                height: 80,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.green,width: 1.5)
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Insert New User", style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNewUserData(),));
              },
              child: SizedBox(
                height: 80,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.green,width: 1.5)
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("View, Update & Delete", style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InsertVideo(),));
              },
              child: SizedBox(
                height: 80,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.green,width: 1.5)
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Insert Video", style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
