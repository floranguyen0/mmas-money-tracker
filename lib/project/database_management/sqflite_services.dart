import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../classes/input_model.dart';

abstract class DB {
  static Database? _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      var databasesPath = await getDatabasesPath();
      String _path = p.join(databasesPath, 'money_crud.db');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static onCreate(Database db, int version) {
    return db.execute(
        'CREATE TABLE input (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, amount REAL, category TEXT, description TEXT, date TEXT, time TEXT)');
  }

  //why in Git uses Future<int>?
  // static Future<List<Map<String, dynamic>>> query() async =>
  //     await _db.query('input');

  static Future<List<InputModel>> inputModelList() async {
    List<Map<String, dynamic>> inputList = await _db!.query('input');
    return inputList.map((item) => InputModel.fromMap(item)).toList();
  }

  static Future<int> insert(InputModel model) async => await _db!.insert(
        'input',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  static Future<int> update(InputModel model) async => await _db!.update(
        'input',
        model.toMap(),
        where: 'id = ?',
        whereArgs: [model.id],
      );

  static Future<int> delete(int id) async =>
      await _db!.delete('input', where: 'id = ?', whereArgs: [id]);

  static Future<int> deleteAll () async =>
      await _db!.delete('input');
}
