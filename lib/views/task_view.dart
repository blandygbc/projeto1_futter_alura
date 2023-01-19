import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/data/task_inherited.dart';
import 'package:tasks_flutter_alura/views/form_view.dart';

class TasksView extends StatefulWidget {
  TasksView({Key? key}) : super(key: key);
  int globalLevel = 0;
  double globalProgressIndicatorValue = 0.0;
  int globalProgressLevel = 0;
  final List<Color> globalLevelColors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.black,
  ];

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.globalLevelColors[widget.globalProgressLevel],
          leading: const Icon(
            Icons.add_task_outlined,
            color: Colors.white,
          ),
          title: Column(
            children: [
              const Text('Tarefas'),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 170,
                    child: LinearProgressIndicator(
                      color: Colors.white,
                      value: widget.globalProgressIndicatorValue,
                    ),
                  ),
                  Text('Nível: ${widget.globalLevel}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      )),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  calculateGlobalProgress();
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (formContext) => FormView(taskContext: context),
                ));
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          children: TaskInherited.of(context)!.taskList,
        ));
  }

  void calculateGlobalProgress() {
    final taskListSize = TaskInherited.of(context)!.taskList.length;
    widget.globalLevel = TaskInherited.of(context)!.taskList.fold(
          0,
          (previousValue, task) => task.progressLevel + previousValue,
        );

    for (var level = 1; level <= 7; level++) {
      if (isTimeToUpgradeGlobalProgress(
        taskListSize: taskListSize,
        level: level,
      )) {
        widget.globalProgressLevel = level;
        break;
      }
    }

    setState(() {
      widget.globalLevel;
      widget.globalProgressIndicatorValue =
          widget.globalLevel / (taskListSize * 7);
    });
  }

  bool isTimeToUpgradeGlobalProgress({
    required int taskListSize,
    required int level,
  }) {
    return widget.globalProgressLevel < level &&
        widget.globalLevel >= (taskListSize * level);
  }
}
