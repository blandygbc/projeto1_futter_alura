import 'package:flutter/material.dart';
import 'package:tasks_flutter_alura/data/task_inherited.dart';
import 'package:tasks_flutter_alura/generated/assets.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Nova Tarefa'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8.0,
                      offset: Offset(
                        2.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'insira o nome da tarefa';
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Nome',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Insira o valor da dificuldade';
                          } else if (int.parse(value) > 5 ||
                              int.parse(value) < 1) {
                            return 'Insira um valor entre 1 e 5';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: difficultyController,
                        decoration: const InputDecoration(
                          hintText: 'Dificuldade',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Insira uma url de imagem!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        onChanged: (text) {
                          setState(() {});
                        },
                        controller: imageController,
                        decoration: const InputDecoration(
                          hintText: 'Imagem',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          //https://ih1.redbubble.net/image.1076687066.0716/st,small,507x507-pad,600x600,f8f8f8.jpg
                          imageController.text,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object ex,
                              StackTrace? stackTrace) {
                            return Image.asset(Assets.imagesNophoto);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TaskInherited.of(widget.taskContext)!.newTask(
                            nameController.text,
                            int.parse(difficultyController.text),
                            imageController.text,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Salvando a tarefa!"),
                          ));
                        }
                        Navigator.pop(context);
                      },
                      child: const Text('Adicionar'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
