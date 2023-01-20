import 'package:flutter/material.dart';

import 'package:tasks_flutter_alura/components/difficulty.dart';
import 'package:tasks_flutter_alura/data/task_dao.dart';

class Task extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final int difficulty;
  final List<Color> levelColors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.black,
  ];
  int taskLevel;
  int progressLevel;
  double progressIndicatorValue;

  Task({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.difficulty,
    required this.taskLevel,
    required this.progressLevel,
    required this.progressIndicatorValue,
  }) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isAsset() {
    if (widget.image.startsWith('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: widget.levelColors[widget.progressLevel],
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5.0,
                  offset: Offset(
                    2.0,
                    2.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: isAsset()
                              ? Image.asset(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Difficulty(
                          level: widget.difficulty,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: 70,
                        height: 60,
                        child: ElevatedButton(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Deletar a tarefa'),
                                  content: const Text(
                                      "Tem certeza que deseja deletar a tarefa?"),
                                  actions: [
                                    TextButton(
                                        onPressed: (() {
                                          Navigator.pop(context);
                                        }),
                                        child: const Text('Não')),
                                    TextButton(
                                        onPressed: () {
                                          TaskDao().delete(widget.id);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Sim')),
                                  ],
                                );
                              },
                            );
                          },
                          onPressed: () async {
                            await calculateProgress();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text('Lvl Up'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: widget.progressIndicatorValue,
                      ),
                    ),
                    Text('Nível: ${widget.taskLevel}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future calculateProgress() async {
    if (isNotMaxProgress()) {
      widget.taskLevel++;
      await TaskDao().save(widget);
      setState(() {});
    }
    if (isTimeToLevelUpProgress()) {
      await progressLevelUp();
    } else {
      await updateProgress();
    }
  }

  bool isNotMaxProgress() {
    return widget.progressLevel <= 6 && widget.progressIndicatorValue < 1;
  }

  bool isTimeToLevelUpProgress() {
    return widget.progressIndicatorValue.compareTo(1) == 0 &&
        widget.progressLevel <= 5;
  }

  Future progressLevelUp() async {
    widget.progressIndicatorValue = 0;
    widget.taskLevel = 0;
    widget.progressLevel++;
    await TaskDao().save(widget);
    setState(() {});
  }

  Future updateProgress() async {
    if (widget.difficulty <= 0) {
      widget.progressIndicatorValue = 1;
      await TaskDao().save(widget);
      setState(() {});
    } else if (widget.progressIndicatorValue < 1) {
      widget.progressIndicatorValue =
          (widget.taskLevel / widget.difficulty) / 10;
      await TaskDao().save(widget);
      setState(() {});
    }
  }
}
