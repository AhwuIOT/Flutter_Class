import 'package:flutter/material.dart';
import 'todo_write.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoAll extends StatefulWidget {
  TodoAll({super.key, required this.tododata});
  List<String> tododata;

  @override
  State<TodoAll> createState() => _TodoAllState();
}

class _TodoAllState extends State<TodoAll> {
  Future<void> saveData() async {}
  List<bool> isChanged = [];
  int count = 0;
  @override
  void initState() {
    super.initState();
    count = widget.tododata.length;
    isChanged = List.generate(count, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.tododata);
    return Scaffold(
        body: ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: Checkbox(
                    value: isChanged[index],
                    onChanged: (value) {
                      setState(() {
                        isChanged[index] = value!;
                        // print(isChanged);
                      });
                    },
                  ),
                  title: Text(widget.tododata[index]));
            }));
  }
}
