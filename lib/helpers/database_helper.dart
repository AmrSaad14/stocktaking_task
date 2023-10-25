import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static const int _version = 1;

//database create
  static Future<void> initDb() async {
    if (_database != null) {
      debugPrint('Database already created');

      return;
    } else {
      debugPrint('create database Start >>>>>>');
      try {
        String path = '${await getDatabasesPath()}products.db';
        debugPrint('in database path $path');
        _database = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
          debugPrint('Creating a new Database');
          // items table creation
          await db.execute('''
  CREATE TABLE items(
    id TEXT PRIMARY KEY ,
    name TEXT,
    barcode TEXT UNIQUE,
    price INTEGER ,
    quantity INTEGER,
    createdAt TEXT,
    updatedAt TEXT)
''');
// stock records table
          await db.execute('''
    CREATE TABLE stock_records(
      document_number INTEGER PRIMARY KEY AUTOINCREMENT,
      record_time TEXT,
      item_id TEXT,
      quantity INTEGER,
      createdAt TEXT,
      updatedAt TEXT,
      FOREIGN KEY (item_id) REFERENCES items(id))
''');
        });
        debugPrint('Database has Created !');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  //read from database
  static Future<List<Map<String, dynamic>>> query(
      {required String tableName}) async {
    debugPrint('query function called');
    return await _database!.query(tableName);
  }

  //database insert
  static Future<int> insert(
      {required dynamic model, required String tableName}) async {
    debugPrint('insert function called');
    try {
      return await _database!.insert(tableName, model.toJson());
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  static Future<List<Map<String, dynamic>>> search(
      {required String searchKeywork}) async {
    debugPrint('search start');
    return await _database!
        .query('items',where: 'barcode LIKE ?',whereArgs: ['%$searchKeywork%']);
  }
}
