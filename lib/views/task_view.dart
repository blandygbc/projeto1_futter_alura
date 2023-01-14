import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/components/task.dart';
import 'package:tasks_flutter_alura/generated/assets.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('Tarefas'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              opacity = !opacity;
            });
          },
          child: const Icon(Icons.remove_red_eye),
        ),
        body: AnimatedOpacity(
          opacity: opacity ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 100),
          child: ListView(
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
              SizedBox(height: 80),
            ],
          ),
        ));
  }
}
