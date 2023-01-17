import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/components/task.dart';
import 'package:tasks_flutter_alura/data/task_inherited.dart';
import 'package:tasks_flutter_alura/generated/assets.dart';
import 'package:tasks_flutter_alura/views/form_view.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('Tarefas'),
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
          children: TaskInherited.of(context)!.taskList,
        ));
  }
}
