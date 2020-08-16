import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  Database _instance;

  static final Db _dataBase = Db._internal();
  Db._internal();
  factory Db() {
    return _dataBase;
  }

  Future<Database> recoverInstance() async {
    if (_instance == null) {
      _instance = await openDB();
    }
    return _instance;
  }

  Future<Database> openDB() async {
    final pathdataBase = await getDatabasesPath();
    final db = await openDatabase(
      join(pathdataBase, 'apiCard.db'),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT,
          password TEXT
          );
        ''');
        await db.execute('''CREATE TABLE appstate (
            id integer primary key autoincrement,
            email text,
            token text
        );
        ''');
      },
      version: 1,
    );
    return db;
  }
}
