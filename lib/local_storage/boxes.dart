import 'package:hive/hive.dart';
import 'package:hive_local_storage/models/todo_model.dart';

class Boxes {
  static Box<TodoModel> getData() => Hive.box("todos");
}
