import 'package:flutter/material.dart';

class TasksProvider extends ChangeNotifier {
  List<Map<String, dynamic>> tasks = [
    {"id": 1, "content": "Anotação 1"},
    {"id": 2, "content": "Anotação 2"},
  ];

  void deleteTask({required int id}) {
    tasks.removeWhere((task) => task["id"] == id);
    notifyListeners();
  }

  void updateTask({required int id, required String text}) {
    final index = tasks.indexWhere((t) => t["id"] == id);
    tasks[index]["content"] = text;
    notifyListeners();
  }

  void createTask({required String text}) {
    tasks.add({"id": DateTime.now().millisecondsSinceEpoch, "content": text});
    notifyListeners();
  }
}
