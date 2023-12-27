import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class UserDataBaseHelper{

  static const dbName = "new_users.db";
  static const dbVersion = 2;
  static const dbTable = "new_user";
  static const newUserId = "id";
  static const newUserName = "name";
  static const newUserAddress = "address";
  static const newUserEmail = "email";
  static const String newUserImage = "image";


  static final UserDataBaseHelper instance = UserDataBaseHelper();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }

  Future onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $dbTable(
      $newUserId INTEGER PRIMARY KEY AUTOINCREMENT,
      $newUserName TEXT NOT NULL,
      $newUserEmail TEXT NOT NULL,
      $newUserAddress TEXT NOT NULL,
      $newUserImage TEXT NOT NULL
      )
      '''
    );

  }

  //create method
  Future<int?> insertData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(dbTable, row);
  }

  //read method
  Future<List<Map<String, dynamic>>?> viewNewUserData() async {
    Database? db = await instance.database;
    return await db?.query(dbTable);
  }

  //update method
  Future<int?> updateNewUserData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[newUserId];
    return await db?.update(dbTable, row, where: '$newUserId = ?', whereArgs: [id]);
  }

  //delete method
  Future<int?> deleteNewUserData(int id) async {
    Database? db = await instance.database;
    return await db?.delete(dbTable, where: 'id = ?', whereArgs: [id]);
  }



}
