import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
                  image:
                      'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
                ),
                Task(
                  name: 'Andar de Bike',
                  dificuldade: 2,
                  image:
                      'https://tswbike.com/wp-content/uploads/2020/09/108034687_626160478000800_2490880540739582681_n-e1600200953343.jpg',
                ),
                Task(
                  name: 'Meditar',
                  dificuldade: 5,
                  image:
                      'https://manhattanmentalhealthcounseling.com/wp-content/uploads/2019/06/Top-5-Scientific-Findings-on-MeditationMindfulness-881x710.jpeg',
                ),
                Task(
                  name: 'Ler',
                  dificuldade: 5,
                  image:
                      'https://thebogotapost.com/wp-content/uploads/2017/06/636052464065850579-137719760_flyer-image-1.jpg',
                ),
                Task(
                  name: 'Jogar',
                  dificuldade: 2,
                  image:
                      'https://i.ibb.co/tB29PZB/kako-epifania-2022-2-c-pia.jpg',
                ),
              ],
            ),
          )),
    );
  }
}

class Task extends StatefulWidget {
  final String name;
  final String image;
  final int dificuldade;

  const Task({
    required this.name,
    Key? key,
    required this.image,
    required this.dificuldade,
  }) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.blue,
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
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 15,
                              color: widget.dificuldade >= 1
                                  ? Colors.blue
                                  : Colors.blue.shade100,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: widget.dificuldade >= 2
                                  ? Colors.blue
                                  : Colors.blue.shade100,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: widget.dificuldade >= 3
                                  ? Colors.blue
                                  : Colors.blue.shade100,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: widget.dificuldade >= 4
                                  ? Colors.blue
                                  : Colors.blue.shade100,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: widget.dificuldade >= 5
                                  ? Colors.blue
                                  : Colors.blue.shade100,
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nivel++;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text('Up'),
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
                    Container(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: widget.dificuldade > 0
                            ? (nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                    Text('Nível: $nivel',
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
}
