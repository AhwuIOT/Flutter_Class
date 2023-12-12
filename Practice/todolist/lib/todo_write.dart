import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/main.dart';
import 'todo_all.dart';

TextEditingController _controller = TextEditingController();
TextEditingController _todocontroller = TextEditingController();

class todoList extends StatefulWidget {
  const todoList({super.key});
  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  String? Todocontent;
  List<String> Uncomplete = [];
  Map<String, bool> isChanged = {};
  Future<void> saveData(String todotask) async {
    print("todo$todotask");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Uncomplete = prefs.getStringList('Uncomplete') ?? [];
      Uncomplete?.forEach((element) {
        isChanged?[element] = prefs.getBool(element) ?? false;
      });
      Uncomplete?.add(todotask);
      isChanged?[todotask] = false;
    });

    await prefs.setStringList('Uncomplete', Uncomplete!);
    await prefs.setBool(todotask, false);
    print("todowrite${Uncomplete} && ${isChanged}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Center(
            child: Text(
          "TodoList",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              //日期的輸入盒
              TextField(
                textDirection: TextDirection.ltr,
                controller: _controller,
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  label: const Text(
                    "日期:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              //ToDo的輸入盒
              TextField(
                  controller: _todocontroller,
                  onTapOutside: (PointerDownEvent) {
                    setState(() {
                      Todocontent = _todocontroller.text;
                    });
                  },
                  decoration: InputDecoration(
                    label: Text(
                      "Todo:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              //OK的按鈕
              TextButton(
                  onPressed: () {
                    setState(() {
                      saveData(Todocontent!);
                      // print("SaveData完data${task['Uncomplete']}");
                      // print("SaveData完${isChanged}");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (contxt) => MyApp()));
                      _todocontroller.text = '';
                      // print("在todowrite的check值${isChanged}");
                    });
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          )),
    );
  }
}

class TodoDate extends StatefulWidget {
  const TodoDate({super.key});

  @override
  State<TodoDate> createState() => _TodoDateState();
}

class _TodoDateState extends State<TodoDate> {
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if ((picked != null) || (picked != selectedDate)) {
      setState(() {
        // picked = picked ?? DateTime.now();
        selectedDate = picked ?? DateTime.now();
        _controller.text =
            "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
      });
      // _loadDate();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => todoList()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: () {
        selectDate(context);
      },
      child: const Icon(
        Icons.add,
        size: 30,
        // color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
