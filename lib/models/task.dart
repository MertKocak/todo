import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  final String id;

  @HiveField(1)
  String taskText;

  @HiveField(2)
  final DateTime crateT;

  @HiveField(3)
  bool isOK;

  Task(
      {required this.id,
      required this.taskText,
      required this.crateT,
      required this.isOK});

  factory Task.olustur({required String taskText, required DateTime crateT}) {
    return Task(
        id: Uuid().v1(), taskText: taskText, crateT: crateT, isOK: false);
  }
}
