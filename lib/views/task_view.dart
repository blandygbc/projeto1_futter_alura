import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/components/task.dart';
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
                  builder: (context) => const FormView(),
                ));
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            Task(
              name: 'Aprender Flutter',
              difficulty: 4,
              image: Assets.imagesDash,
            ),
            Task(
              name: 'Andar de Bike',
              difficulty: 1,
              image: Assets.imagesBike,
            ),
            Task(
              name: 'Meditar',
              difficulty: 5,
              image: Assets.imagesMeditar,
            ),
            Task(
              name: 'Ler',
              difficulty: 5,
              image: Assets.imagesLivro,
            ),
            Task(
              name: 'Jogar',
              difficulty: 0,
              image: Assets.imagesJogar,
            ),
            const SizedBox(height: 80),
          ],
        ));
  }
}
