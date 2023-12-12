import 'todo_all.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'todo_write.dart';
import 'todo_complet.dart';

//設定主題顏色跟副顏色的地方
ThemeData mainTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.yellow,
      secondary: Colors.white,
    ));

void main() {
  runApp(MyApp());
}

//內容主要分成appbar，body,floatingactionbutton
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // List<String>? data;
  // Map<String, bool>? isChanged;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      home: FetchData(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FetchData extends StatefulWidget {
  FetchData({
    super.key,
  });

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  List<String> Uncomplete = [];
  Map<String, bool> isChanged = {};
  List<String> Complete = [];

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Uncomplete = prefs.getStringList('Uncomplete') ?? [];
      Complete = prefs.getStringList('Complete') ?? [];
      for (int i = 0; i < Uncomplete.length; i++) {
        isChanged[Uncomplete[i]] = prefs.getBool(Uncomplete[i]) ?? false;
      }
    });
  }

  Future<void> Reset_btn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Uncomplete', []);
    await prefs.setStringList('Complete', []);
    await prefs.setStringList('isChanged', []);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contxt) => todoComplete()));
                });
              },
              icon: const Icon(Icons.add_task))
        ],
        leading: TextButton(
          child: const Text(
            "Reset",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            setState(() {
              Reset_btn();
            });
          },
        ),
        backgroundColor: mainTheme.colorScheme.primary,
        title: const Center(
            child: Text(
          "TodoList",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        )),
      ),
      body: TodoAll(),
      floatingActionButton: TodoDate(),
    );
  }
}
