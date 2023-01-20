import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/components/task.dart';
import 'package:tasks_flutter_alura/generated/assets.dart';
import 'package:uuid/uuid.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required this.child}) : super(child: child);
  static const uuid = Uuid();
  final Widget child;
  final List<Task> taskList = [
    Task(
      id: uuid.v4(),
      name: 'Aprender Flutter',
      difficulty: 4,
      image: Assets.imagesDash,
      taskLevel: 0,
      progressLevel: 0,
      progressIndicatorValue: 0.0,
    ),
    Task(
      id: uuid.v4(),
      name: 'Andar de Bike',
      difficulty: 2,
      image: Assets.imagesBike,
      taskLevel: 0,
      progressLevel: 0,
      progressIndicatorValue: 0.0,
    ),
    Task(
      id: uuid.v4(),
      name: 'Meditar',
      difficulty: 5,
      image: Assets.imagesMeditar,
      taskLevel: 0,
      progressLevel: 0,
      progressIndicatorValue: 0.0,
    ),
    Task(
      id: uuid.v4(),
      name: 'Ler',
      difficulty: 5,
      image: Assets.imagesLivro,
      taskLevel: 0,
      progressLevel: 0,
      progressIndicatorValue: 0.0,
    ),
    Task(
      id: uuid.v4(),
      name: 'Jogar',
      difficulty: 1,
      image: Assets.imagesJogar,
      taskLevel: 0,
      progressLevel: 0,
      progressIndicatorValue: 0.0,
    ),
  ];

  void newTask(String name, int difficulty, String image) {
    taskList.add(Task(
      id: uuid.v4(),
      name: name,
      image: image,
      difficulty: difficulty,
      taskLevel: 0,
      progressLevel: 0,
      progressIndicatorValue: 0.0,
    ));
  }

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
