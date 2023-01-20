import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as dartPath;
import 'package:tasks_flutter_alura/data/task_dao.dart';

Future<Database> getDatabase() async {
  final String path = dartPath.join(await getDatabasesPath(), 'task.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TaskDao.tableSql);
    },
    version: 1,
  );
}
