import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  int userId;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool completed;

  TodoModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });
}
