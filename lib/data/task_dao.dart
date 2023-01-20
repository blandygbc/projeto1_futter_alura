import 'package:tasks_flutter_alura/components/task.dart';

class TaskDao {
  static const String tableSql = '''
                                  CREATE TABLE $_tableName(
                                    $_name TEXT,
                                    $_difficulty INTEGER,
                                    $_image TEXT, 
                                  );
                                  ''';

  static const String _tableName = 'tasks';
  static const String _name = 'name';
  static const String _difficulty = 'diffiulty';
  static const String _image = 'image';

  save(Task task) async {}
  Future<List<Task>> findAll() async {}
  Future<List<Task>> find(String taskName) async {}
  delete(int id) async {}
}
