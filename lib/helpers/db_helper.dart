import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'transaction.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
  }

  static void _createDb(Database db) {
    db.execute(
        'CREATE TABLE user_transactions(id TEXT PRIMARY KEY, title TEXT, subtitle TEXT, spent_time REAL, date TEXT)');
    db.execute(
        'CREATE TABLE user_done_choices(id TEXT PRIMARY KEY, key TEXT, items TEXT)');
    // db.execute(
    //     'CREATE TABLE user_spent_times(id TEXT PRIMARY KEY, key TEXT, time REAL)');
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
