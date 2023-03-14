import 'package:flutter/material.dart';
import 'package:hive_local_storage/local_storage/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_storage/models/todo_model.dart';

class SavedTodoScreen extends StatefulWidget {
  const SavedTodoScreen({super.key});

  @override
  State<SavedTodoScreen> createState() => _SavedTodoScreenState();
}

class _SavedTodoScreenState extends State<SavedTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Todos"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<TodoModel>();
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final id = data[index].id;
                final title = data[index].title;
                final isCompleted = data[index].completed;
                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: isCompleted ? Colors.green : Colors.red,
                    ),
                    title: Text("ID $id"),
                    subtitle: Text(title),
                  ),
                );
              });
        },
      ),
    );
  }
}
