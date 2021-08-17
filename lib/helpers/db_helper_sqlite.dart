import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'expe.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses(id TEXT PRIMARY KEY, name TEXT, amount TEXT, date TEXT);',
        );
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper.database();
    return sqlDb.query(table);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.database();
    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(String table, String id) async {
    final sqlDb = await DBHelper.database();
    await sqlDb.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> drop() async {
    final sqlDb = await DBHelper.database();
    await sqlDb.execute('DELETE FROM expenses;');
  }
}
