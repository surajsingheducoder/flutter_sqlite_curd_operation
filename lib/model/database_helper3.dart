import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class VideoDataBaseHelper{

  static const dbName = "local_videos.db";
  static const dbVersion = 3;
  static const dbTable = "local_video";
  static const videoId = "id";
  static const videoTitle = "title";
  static const String localVideo = "video";


  static final VideoDataBaseHelper instance = VideoDataBaseHelper();

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
      $videoId INTEGER PRIMARY KEY AUTOINCREMENT,
      $videoTitle TEXT NOT NULL,
      $localVideo TEXT NOT NULL
      )
      '''
    );

  }

  //create method
  Future<int?> insertVideoData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(dbTable, row);
  }

  //read method
  Future<List<Map<String, dynamic>>?> viewVideoData() async {
    Database? db = await instance.database;
    return await db?.query(dbTable);
  }

  //update method
  Future<int?> updateVideoData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[videoId];
    return await db?.update(dbTable, row, where: '$videoId = ?', whereArgs: [id]);
  }

  //delete method
  Future<int?> deleteVideoData(int id) async {
    Database? db = await instance.database;
    return await db?.delete(dbTable, where: 'id = ?', whereArgs: [id]);
  }



}
