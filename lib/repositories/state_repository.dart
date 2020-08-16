import 'package:app_cards/database/database.dart';
import 'package:app_cards/entities/state.dart';

class AppStateRepository {
  final _table = 'appstate';
  final _dbHelper = Db();

  Future<AppState> getCurrent() async {
    final db = await _dbHelper.openDB();
    final result = await db.query(_table);
    if (result.isNotEmpty) {
      return AppState.fromDatabase(result.first);
    }
    return null;
  }

  Future<void> save(AppState appState) async {
    final db = await _dbHelper.openDB();
    await db.transaction((txn) async {
      await txn.delete(_table);
      await txn.insert(_table, appState.toMap());
    });
  }

  Future<void> clear() async {
    final db = await _dbHelper.openDB();
    await db.delete(_table);
  }
}
