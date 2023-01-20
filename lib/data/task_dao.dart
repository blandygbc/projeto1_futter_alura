import 'package:sqflite/sqflite.dart';
import 'package:tasks_flutter_alura/components/task.dart';
import 'package:tasks_flutter_alura/data/database.dart';

class TaskDao {
  static const String tableSql = '''
                                  CREATE TABLE $_tableName(
                                    $_id TEXT NOT NULL,
                                    $_name TEXT,
                                    $_difficulty INTEGER,
                                    $_image TEXT,
                                    $_taskLevel INTEGER,
                                    $_taskProgressLevel INTEGER,
                                    $_taskProgressIndicatorValue REAL,
                                    PRIMARY KEY($_id)
                                  );
                                  ''';

  static const String _id = 'id';
  static const String _tableName = 'tasks';
  static const String _name = 'name';
  static const String _difficulty = 'diffiulty';
  static const String _image = 'image';
  static const String _taskLevel = 'level';
  static const String _taskProgressLevel = 'progress_level';
  static const String _taskProgressIndicatorValue = 'progress_indcator_value';

  Future<int> save(Task task) async {
    final Database db = await getDatabase();
    List<Task> itemExists = await find(task.id);
    final taskMap = toMap(task);
    if (itemExists.isEmpty) {
      return await db.insert(_tableName, taskMap);
    } else {
      return await db.update(
        _tableName,
        taskMap,
        where: '$_id = ?',
        whereArgs: [task.id],
      );
    }
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(_tableName);
    return toList(result);
  }

  Future<List<Task>> find(String id) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
    return toList(result);
  }

  Future<int> delete(String id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  List<Task> toList(List<Map<String, dynamic>> tasksMap) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in tasksMap) {
      final Task task = Task(
        id: row[_id],
        name: row[_name],
        image: row[_image],
        difficulty: row[_difficulty],
        taskLevel: row[_taskLevel],
        progressLevel: row[_taskProgressLevel],
        progressIndicatorValue: row[_taskProgressIndicatorValue],
      );
      tasks.add(task);
    }
    return tasks;
  }

  Map<String, dynamic> toMap(Task task) {
    return {
      _id: task.id,
      _name: task.name,
      _image: task.image,
      _difficulty: task.difficulty,
      _taskLevel: task.taskLevel,
      _taskProgressLevel: task.progressLevel,
      _taskProgressIndicatorValue: task.progressIndicatorValue,
    };
  }
}
