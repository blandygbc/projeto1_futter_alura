import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/components/task.dart';
import 'package:tasks_flutter_alura/generated/assets.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required this.child}) : super(child: child);

  final Widget child;
  final List<Task> taskList = [
    Task(name: 'Aprender Flutter', difficulty: 4, image: Assets.imagesDash),
    Task(name: 'Andar de Bike', difficulty: 1, image: Assets.imagesBike),
    Task(name: 'Meditar', difficulty: 5, image: Assets.imagesMeditar),
    Task(name: 'Ler', difficulty: 5, image: Assets.imagesLivro),
    Task(name: 'Jogar', difficulty: 0, image: Assets.imagesJogar),
  ];

  void newTask(String name, int difficulty, String image) {
    taskList.add(Task(name: name, image: image, difficulty: difficulty));
  }

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
