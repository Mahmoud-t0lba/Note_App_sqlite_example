// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MySql {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'test.db');
    Database myDb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 4,
      // onUpgrade: _onUpgrade,
    );
    return myDb;
  }

  _onCreate(Database db, int version) async {
    /*
    لو عايز جدول تاني بكرر نفس الكود ده
     اسم الكولوم مينفعش يكون نفس اسم الجدول
    اسم الكولوم يفضل يكون بين quotation
    */

    await db.execute(
      '''
          CREATE TABLE "notes"(
          "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
          "title"	TEXT NOT NULL,
          "note"	TEXT NOT NULL
          )
          ''',
    );

    print('CREATE DATABASE AND TABLE >>>>>>>>>');
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('<<<<<<<<<<<<<<<<<<< onUpgrade >>>>>>>>>>>>>>>>>>>');
    // await db.execute("ALERT TABLE notes ADD COLUMN color TEXT");
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  deleteAllDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'test.db');

    await deleteDatabase(path);
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

}
