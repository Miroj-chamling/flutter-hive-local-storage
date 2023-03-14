import 'package:flutter/material.dart';
import 'package:hive_local_storage/local_storage/boxes.dart';
import 'package:hive_local_storage/models/todo_model.dart';
import 'package:hive_local_storage/provider/todo_provider.dart';
import 'package:hive_local_storage/screens/savedtodoscreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TodoProvider>(context, listen: false).getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todos"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SavedTodoScreen();
              }));
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) => value.isLoaing
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: value.todoList.length,
                itemBuilder: (context, index) {
                  final id = value.todoList[index].id;
                  final title = value.todoList[index].title;
                  final isCompleted = value.todoList[index].completed;
                  final userId = value.todoList[index].userId;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(
                          "ID $id",
                        ),
                        subtitle: Text(title),
                        leading: Icon(
                          Icons.circle,
                          color: isCompleted ? Colors.green : Colors.red,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            final data = TodoModel(
                              id: id,
                              userId: userId,
                              title: title,
                              completed: isCompleted,
                            );
                            final box = Boxes.getData();
                            box.add(data);
                            data.save();
                            print(box);
                          },
                          child: const Text("Save"),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
