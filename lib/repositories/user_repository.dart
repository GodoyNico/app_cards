import 'package:app_cards/database/database.dart';
import 'package:app_cards/entities/user.dart';

class UserRepository {
  final _table = 'user';
  final _dbHelper = Db();

  Future<User> getCurrent() async {
    final db = await _dbHelper.openDB();
    final result = await db.query(_table);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<void> save(User user) async {
    final db = await _dbHelper.openDB();
    await db.transaction((txn) async {
      await txn.delete(_table);
      await txn.insert(_table, user.toMap());
    });
  }

  Future<void> clear() async {
    final db = await _dbHelper.openDB();
    await db.delete(_table);
  }
}
