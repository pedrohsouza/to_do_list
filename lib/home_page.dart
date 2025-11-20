import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_page.dart';
import 'task_card.dart';
import 'tasks_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> tasks = [];

  // @override
  // void initState() {
  //   tasks = [
  //     {"id": 1, "content": "Anotação 1"},
  //     {"id": 2, "content": "Anotação 2"},
  //   ];
  //   super.initState();
  // }

  void deleteTask({required int id}) {
    // setState(() {
    //   tasks.removeWhere((task) => task["id"] == id);
    // });

    context.read<TasksProvider>().deleteTask(id: id);

    showSnackBar();
    Navigator.pop(context);
  }

  void showSnackBar() {
    const snackBar = SnackBar(
      content: Text('Anotação excluída com sucesso!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: context.watch<TasksProvider>().tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskCard(
                task: context.watch<TasksProvider>().tasks[index],
                onDelete: deleteTask,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
