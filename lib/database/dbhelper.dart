import 'dart:developer';

import 'package:flutter_calender/model/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;
  String id = 'id';
  String title = 'title';
  String fromDate = 'fromDate';
  String toDate = 'toDate';
  String background = 'background';
  String colorTitle = 'colorTitle';
  String eventType = 'eventType';
  String table = 'Event';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initialDatabase();
    return _db!;
  }

  Future<Database> initialDatabase() async {
    final d1 = await getApplicationDocumentsDirectory();
    String path = join(d1.path, "Event4.db");
    var db = await openDatabase(path, version: 5, onCreate: onCreate);
    return db;
  }

  onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY AUTOINCREMENT,$title TEXT,$fromDate TEXT,$toDate TEXT,$background TEXT,$colorTitle TEXT,$eventType TEXT)');
  }

  Future<int> insert(Event event) async {
    final db = await this.db;
    int id = await db.insert(table, event.toMap());
    return id;
  }

  Future<List<Event>> getEventList() async {
    final db = await this.db;
    final List<Map<String, Object?>> result = await db.query(table);
    return result.map((e) => Event.fromMap(e)).toList();
  }

  Future<int> update(Event event) async {
    final db = await this.db;
    return await db
        .update(table, event.toMap(), where: '$id=?', whereArgs: [event.id]);
  }

  Future<List<Event>> fetchCurrentRow(int id) async {
    final db = await this.db;
    final List<Map<String, Object?>> data =
        await db.query(table, where: '${this.id}=?', whereArgs: [id]);
    return data.map((e) => Event.fromMap(e)).toList();
 
  }

  Future<int> delete(int id) async {
    print(id);
    final db = await this.db;
    await db.delete(table, where: '${this.id}=?', whereArgs: [id]);
    return id;
  }
}
