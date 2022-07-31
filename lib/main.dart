import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/home_page.dart';
import 'package:todo/models/task.dart';

final locater = GetIt.instance;
bool renk = true;
var koyu = Color.fromARGB(255, 202, 54, 17);
var acik = Color.fromARGB(255, 255, 249, 241);
var koyu1 = Color.fromARGB(234, 145, 57, 6);
var acik1 = Color.fromARGB(255, 17, 17, 17);

void setup() {
  locater.registerSingleton<LocalStorage>(HiveLocalStorage());
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var taskBox = await Hive.openBox<Task>("tasks");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}
