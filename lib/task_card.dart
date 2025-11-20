import 'package:flutter/material.dart';

import 'note_page.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final void Function({required int id}) onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(task: task),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(task['content']),
              const Spacer(),
              Column(
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Excluir'),
                            content: const Text(
                                'Tem certeza que deseja excluir a nota?'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  onDelete(id: task['id']);
                                },
                                child: const Text('Excluir'),
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text("Excluir"),
                    style: const ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size(115, 40)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
