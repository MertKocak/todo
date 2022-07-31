import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  final Task task;
  TaskList({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TextEditingController _taskName = TextEditingController();
  late LocalStorage _localStorage;
  @override
  void initState() {
    super.initState();
    _localStorage = locater<LocalStorage>();
    _taskName.text = widget.task.taskText;
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: renk ? koyu.withOpacity(.9): koyu1.withOpacity(.8),
        borderRadius: BorderRadius.circular(28),
      ),
      child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.task.isOK = !widget.task.isOK;
              _localStorage.updateTask(task: widget.task);
              setState(() {});
            },
            child: Container(
                margin: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: widget.task.isOK ? Colors.grey.shade900 : acik,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: renk ? acik: acik,
                )),
          ),
          title: widget.task.isOK
              ? Text(widget.task.taskText,
                  style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.lineThrough,
                      color: renk ? Colors.grey.shade900: Colors.black,
                      fontFamily: "quick"))
              : TextField(
                  minLines: 1,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  controller: _taskName,
                  style:
                      TextStyle(color: renk ? acik: Color.fromARGB(255, 194, 194, 194), fontSize: 18, fontFamily: "quick"),
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (yenideger) {
                    widget.task.taskText = yenideger;
                    _localStorage.updateTask(task: widget.task);
                  },
                ),
          trailing: widget.task.isOK
              ? Text(
                  DateFormat('d MMMM\nhh:mm').format(widget.task.crateT),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: renk ? Color.fromARGB(255, 194, 194, 194) : Colors.grey.shade900,
                      fontFamily: "quick",
                      fontSize: 16),
                )
              : Text(
                  DateFormat('d MMMM\nhh:mm').format(widget.task.crateT),
                  style:
                      TextStyle(color: renk ? acik: Color.fromARGB(255, 218, 218, 218), fontFamily: "quick", fontSize: 16),
                )),
    );
  }
}
