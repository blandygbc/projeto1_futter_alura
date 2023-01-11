import 'package:flutter/material.dart';
import 'package:projeto1_futter_alura/components/task.dart';

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
            children: const [
              Task(
                name: 'Aprender Flutter',
                dificuldade: 4,
                image: 'assets/images/dash.png',
              ),
              Task(
                name: 'Andar de Bike',
                dificuldade: 2,
                image: 'assets/images/bike.webp',
              ),
              Task(
                name: 'Meditar',
                dificuldade: 5,
                image: 'assets/images/meditar.jpeg',
              ),
              Task(
                name: 'Ler',
                dificuldade: 5,
                image: 'assets/images/livro.jpg',
              ),
              Task(
                name: 'Jogar',
                dificuldade: 2,
                image: 'assets/images/jogar.jpg',
              ),
              SizedBox(height: 80),
            ],
          ),
        ));
  }
}
