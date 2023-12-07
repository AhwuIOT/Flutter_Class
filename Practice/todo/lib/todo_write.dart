import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'todo_all.dart';

TextEditingController _controller = TextEditingController();
TextEditingController _todocontroller = TextEditingController();
String Todocontent = '';
Map<String, List<String>> task = {'Complete': [], 'Uncomplete': []};
Map<String, List<String>> taskContent = {};

class todoList extends StatefulWidget {
  const todoList({super.key});
  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  Future<void> setTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    task['Uncomplete'] =
        prefs.getStringList('Uncomplete') ?? task['Uncomplete']!;
    task['Uncomplete']!.add(Todocontent);
    await prefs.setStringList('Uncomplete', task['Uncomplete']!);
  }

  Future<void> loadTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getStringList('Uncomplete'));
    task['Uncomplete'] =
        prefs.getStringList('Uncomplete') ?? task['Uncomplete']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
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
              TextField(
                textDirection: TextDirection.ltr,
                controller: _controller,
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  label: Text(
                    "日期:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
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
              TextButton(
                  onPressed: () {
                    setState(() {
                      task['Uncomplete']!.add(Todocontent);
                      print(task['Uncomplete']);
                      setTask();
                      loadTask();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contxt) => MyApp(
                                    data: task['Uncomplete'] ?? [],
                                  )));
                      _todocontroller.text = '';
                    });
                  },
                  child: Text(
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
  Future<void> _loadDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String date = selectedDate.toLocal().toString() ?? '';
    // print(date);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controller.text = "${picked.year}/${picked.month}/${picked.day}";
      });
      _loadDate();
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
      child: Icon(
        Icons.add,
        size: 30,
        // color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
