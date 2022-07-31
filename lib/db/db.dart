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
    String path = join(dataBasePath, 'XXX.db');
    Database myDb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      // onUpgrade: _onUpgrade,
    );
    return myDb;
  }

  // _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   print('<<<<<<<<<<<<<<<<<<< onUpgrade >>>>>>>>>>>>>>>>>>>');
  //   await db.execute("ALERT TABLE notes ADD COLUMN color TEXT");
  // }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  _onCreate(Database db, int version) async {
    /*
    لو عايز جدول تاني بكرر نفس الكود ده
     اسم الكولوم مينفعش يكون نفس اسم الجدول
    اسم الكولوم يفضل يكون بين quotation
    */

    await db.execute(
      '''
          CREATE TABLE notes(
          id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
          title	TEXT,
          note	TEXT,
          color	TEXT
          )
          ''',
    );

    print('CREATE DATABASE AND TABLE >>>>>>>>>');
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
    String path = join(dataBasePath, 'XXX.db');

    await deleteDatabase(path);
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ///      /* shortened function */
  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  insert(String table, Map<String, Object?> val) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, val);
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  delete(String table, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete(
      table,
      where: myWhere,
    );
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  update(String table, Map<String, Object?> val, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update(
      table,
      val,
      where: myWhere,
    );
    return response;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

}
