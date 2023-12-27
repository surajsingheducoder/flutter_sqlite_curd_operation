import 'package:flutter/material.dart';
import 'package:new_assignment/view/dashboard.dart';
import 'package:new_assignment/view/login_page.dart';
import 'package:new_assignment/view/register_page.dart';
import 'package:provider/provider.dart';

import 'controller/user_controller.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
