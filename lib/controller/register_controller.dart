// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import '../model/database_helper.dart';
// import '../model/user_model.dart';
//
//
// class RegistrationProvider extends ChangeNotifier {
//   final Database databaseHelper = DatabaseHelper() as Database;
//
//   Future<void> registerUser(User user) async {
//     try {
//       await databaseHelper.insertUser(user);
//     } catch (e) {
//       throw e;
//     }
//     notifyListeners();
//   }
// }