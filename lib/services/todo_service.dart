import 'dart:convert';
import 'package:hive_local_storage/models/todo_model.dart';
import "package:http/http.dart" as http;

class TodoService {
  Future<List<TodoModel>> getAll() async {
    const url = "https://jsonplaceholder.typicode.com/todos";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final todos = json
          .map(
            (data) => TodoModel(
              id: data["id"],
              userId: data["userId"],
              title: data["title"],
              completed: data["completed"],
            ),
          )
          .toList();
      return todos;
    } else {
      return [];
    }
  }
}
