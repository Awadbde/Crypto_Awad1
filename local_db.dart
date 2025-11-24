import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/status_update.dart';

class LocalDB {
  static Database? _db;

  static Future<void> init() async {
    if (_db != null) return;
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'crypto_awad.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('''CREATE TABLE favorites(id TEXT PRIMARY KEY, category TEXT, description TEXT, createdAt TEXT, project TEXT)''');
    });
  }

  static Future<void> addFavorite(StatusUpdate u) async {
    await _db!.insert('favorites', u.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removeFavorite(String id) async {
    await _db!.delete('favorites', where: 'id=?', whereArgs: [id]);
  }

  static Future<List<StatusUpdate>> getFavorites() async {
    final rows = await _db!.query('favorites');
    return rows.map((r) => StatusUpdate.fromJson(r)).toList();
  }
}
