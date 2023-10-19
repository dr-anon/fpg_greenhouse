import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE threshold(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      temperature TEXT,
      humidity TEXT,
      ph TEXT,
      moisture TEXT
      
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('save.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(
      String temperature, String humidity, String ph, String moisture) async {
    final db = await SQLHelper.db();
    final data = {
      'temperature': temperature,
      'humidity': humidity,
      'ph': ph,
      'moisture': moisture
    };
    final id = await db.insert('threshold', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('threshold',orderBy: "id");
  }

  static Future<List<Map<String,dynamic>>> getItem(int id) async{
    final db = await SQLHelper.db();
    return db.query('threshold', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
    int id, String temperature, String humidity, String ph, String moisture
  ) async {
    final db = await SQLHelper.db();
    final data = {
      'temperature': temperature,
      'humidity': humidity,
      'ph': ph,
      'moisture': moisture
    };
    final result = await db.update('threshold', data, where:"id = ?", whereArgs: [id]);
    return result;
  }
}
