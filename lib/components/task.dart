import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/components/difficulty.dart';

class Task extends StatefulWidget {
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

  Task({
    required this.name,
    Key? key,
    required this.image,
    required this.difficulty,
  }) : super(key: key);

  int taskLevel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int progressLevel = 0;
  double progressIndicatorValue = 0.0;

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
              color: widget.levelColors[progressLevel],
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
                          onPressed: () {
                            calculateProgress();
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
                        value: progressIndicatorValue,
                      ),
                    ),
                    Text('Nível: $widget.taskLevel',
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

  void calculateProgress() {
    if (isNotMaxProgress()) {
      widget.taskLevel++;
    }
    if (isTimeToLevelUpProgress()) {
      progressLevelUp();
    } else {
      updateProgress();
    }
  }

  bool isNotMaxProgress() {
    return progressLevel <= 6 && progressIndicatorValue < 1;
  }

  bool isTimeToLevelUpProgress() {
    return progressIndicatorValue.compareTo(1) == 0 && progressLevel <= 5;
  }

  void progressLevelUp() {
    setState(() {
      progressIndicatorValue = 0;
      widget.taskLevel = 0;
      progressLevel++;
    });
  }

  void updateProgress() {
    if (widget.difficulty <= 0) {
      setState(() {
        progressIndicatorValue = 1;
      });
    } else if (progressIndicatorValue < 1) {
      setState(() {
        progressIndicatorValue = (widget.taskLevel / widget.difficulty) / 10;
      });
    }
  }
}
