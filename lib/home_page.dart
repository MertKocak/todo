import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/task_list_items.dart';

class HomePage extends StatefulWidget {
  
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late List<Task> _allTasks;
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locater<LocalStorage>();
    _allTasks = <Task>[];
    _getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: renk ? acik : acik1,
        bottomOpacity: 0,
        title: Text(
          "to do",
          style: TextStyle(color: renk ? koyu : koyu1, fontSize: 26, fontFamily: "quick",),
        ),
        backgroundColor: renk ? acik : Color.fromARGB(255, 0, 0, 0),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  YeniNot(context);
                },
                icon: Icon(
                  Icons.note_add_rounded,
                  size: 32,
                  color: renk ? koyu : koyu1,
                )),
          ),
          GestureDetector(
            onTap: () {
              renk = !renk;
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  renk ? Icons.dark_mode_rounded : Icons.light_mode,
                  size: 32,
                  color: renk ? Color.fromARGB(255, 77, 77, 77) : Color.fromARGB(255, 201, 201, 201),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: renk ? acik: acik1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _allTasks.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    var anlikEleman = _allTasks[index];
                    return Dismissible(
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_rounded,
                              size: 26,
                              color: renk ? Colors.grey.shade800: Color.fromARGB(255, 201, 201, 201),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Görev silindi.",
                              style: TextStyle(
                                  color: renk ? Colors.grey.shade800 :Color.fromARGB(255, 201, 201, 201),
                                  fontSize: 18,
                                  fontFamily: "quick"),
                            ),
                          ],
                        ),
                        key: Key(anlikEleman.id),
                        onDismissed: (direction) {
                          _allTasks.removeAt(index);
                          _localStorage.deleteTask(task: anlikEleman);
                          setState(() {});
                        },
                        child: TaskList(task: anlikEleman));
                  },
                  itemCount: _allTasks.length,
                )
              : Center(
                  child: Container(
                    child: Text(
                      "Görev Ekle",
                      style: TextStyle(
                          color: renk ? koyu : koyu1,
                          fontSize: 22,
                          fontFamily: "quick"),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void YeniNot(BuildContext context) {
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              style: TextStyle(
                color: renk ? koyu : koyu1,
                fontSize: 20,
                fontFamily: "quick",
              ),
              decoration: InputDecoration(
                hintText: "Yeni Görev Ekle",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: renk ? koyu.withOpacity(.5) : koyu1.withOpacity(.5),
                    fontSize: 20,
                    fontFamily: "quick"),
              ),
              onSubmitted: (value) {
                Navigator.of(context).pop();
                 DatePicker.showDateTimePicker(context, onConfirm: (time) async {
                  var newTask = Task.olustur(taskText: value, crateT: time);
                  _allTasks.insert(0, newTask);
                  await _localStorage.addTask(task: newTask);
                  setState(() {});
                }); 
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _getAllTaskFromDb() async {
    _allTasks = await _localStorage.getAllTask();
    setState(() {});
  }
}


