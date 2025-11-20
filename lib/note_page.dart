import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tasks_provider.dart';

class NotePage extends StatefulWidget {
  final Map<String, dynamic>? task;

  const NotePage({super.key, this.task});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _noteController.text = widget.task!["content"];
    }
  }

  void showSnackBar(String snackBarMessage) {
    var snackBar = SnackBar(
      content: Text(snackBarMessage),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _noteController,
                  // minLines: 10,
                  // maxLines: 100,
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null,
                  // expands: true,
                  decoration: const InputDecoration(
                    hintText: "Digite sua nota...",
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String snackBarMessage;
          if (widget.task != null) {
            context.read<TasksProvider>().updateTask(
                  text: _noteController.text,
                  id: widget.task!["id"],
                );
            snackBarMessage = 'Alterações salvas com sucesso!';
          } else {
            context
                .read<TasksProvider>()
                .createTask(text: _noteController.text);
            snackBarMessage = 'Nota criada com sucesso!';
          }
          showSnackBar(snackBarMessage);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.save),
        label: const Text("Salvar"),
      ),
    );
  }
}
