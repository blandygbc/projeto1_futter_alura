import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/components/task.dart';
import 'package:tasks_flutter_alura/data/task_dao.dart';
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
                onPressed: () async {
                  await calculateGlobalProgress();
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
              ),
            ).then((value) {
              setState(() {});
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    List<Task> items = snapshot.data as List<Task>;
                    if (items.isNotEmpty) {
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final Task task = items[index];
                          return task;
                        },
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.error_outline, size: 48),
                          SizedBox(height: 10),
                          Text('Sem tarefas, adicione uma no botão "+"',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Não foi possível recuperar as tarefas'),
                    );
                  }
                default:
                  return const Center(
                    child: Text('Houve um problema para acessar o banco',
                        style: TextStyle(fontSize: 20)),
                  );
              }
            },
          ),
        ));
  }

  Future calculateGlobalProgress() async {
    final tasks = await TaskDao().findAll();
    if (tasks.isNotEmpty) {
      final taskListSize = tasks.length;
      widget.globalLevel = tasks.fold(
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
    } else {
      setState(() {
        widget.globalLevel = 0;
        widget.globalProgressLevel = 0;
        widget.globalProgressIndicatorValue = 0.0;
      });
    }
  }

  bool isTimeToUpgradeGlobalProgress({
    required int taskListSize,
    required int level,
  }) {
    return widget.globalProgressLevel < level &&
        widget.globalLevel >= (taskListSize * level);
  }
}
