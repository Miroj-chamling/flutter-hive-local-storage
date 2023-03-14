import 'package:flutter/material.dart';
import 'package:hive_local_storage/models/todo_model.dart';
import 'package:hive_local_storage/services/todo_service.dart';

class TodoProvider with ChangeNotifier {
  final _service = TodoService();
  bool isLoaing = false;

  List<TodoModel> _todoList = [];
  List<TodoModel> get todoList => _todoList;

  Future<void> getAllTodos() async {
    isLoaing = true;
    notifyListeners();

    final response = await _service.getAll();
    _todoList = response;

    isLoaing = false;
    notifyListeners();
  }
}
