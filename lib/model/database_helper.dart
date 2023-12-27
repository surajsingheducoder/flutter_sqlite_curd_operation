import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //variables
  static const dbName = "userDatabase.db";
  static const dbVersion = 1;
  static const dbTable = "userTable";
  static const userId = "id";
  static const String userImagePath="pic";
  static const userName = "name";
  static const userEmail = "email";
  static const userAddress = "address";

  //constructor
  static final DatabaseHelper instance = DatabaseHelper();

  //database initialize
  static Database? _database;
  
  DatabaseHelper(){
    print("Database Constructor");
  }

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    print("Initilizing database");

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    print("Database path $path");

    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);

    return _database;
  }

  Future onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $dbTable(
      $userId INTEGER PRIMARY KEY AUTOINCREMENT,
      $userName TEXT NOT NULL,
      $userEmail TEXT NOT NULL,
      $userAddress TEXT NOT NULL,
      $userImagePath TEXT NOT NULL
      )
      '''
    );
  }

  //insert method
  Future<int?> insertUserRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(dbTable, row);
  }

  Future<List<Map<String, dynamic>>?> viewUserData() async {
  Database? db = await instance.database;
  return await db?.query(dbTable);
  }

  Future<int?> updateUserData(Map<String, dynamic> row) async {
  Database? db = await instance.database;
  int id = row[userId];
  return await db?.update(dbTable, row, where: '$userId = ?', whereArgs: [id]);
  }

  Future<int?> deleteUserData(int id) async {
    Database? db = await instance.database;
    return await db?.delete(dbTable, where: 'id = ?', whereArgs: [id]);
  }



}
