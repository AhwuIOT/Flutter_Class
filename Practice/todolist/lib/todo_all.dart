import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoAll extends StatefulWidget {
  const TodoAll({super.key});

  @override
  State<TodoAll> createState() => _TodoAllState();
}

class _TodoAllState extends State<TodoAll> {
  Map<String, bool> isChanged = {};
  List<String> Uncomplete = [];
  List<String> Complete = [];
  Future<void> saveCheck(bool isCheck, String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isChanged[data] = isCheck;
    });

    Complete = prefs.getStringList('Complete') ?? [];

    if (isChanged[data]!) {
      Complete.add(data);
      Uncomplete.remove(data);
    } else {
      Complete.remove(data);
      Uncomplete.add(data);
    }
    await prefs.setBool(data, isCheck);
    await prefs.setStringList('Complete', Complete);
    await prefs.setStringList('Uncomplete', Uncomplete);
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      Complete = prefs.getStringList('Complete') ?? [];
      Uncomplete = prefs.getStringList('Uncomplete') ?? [];
      for (int i = 0; i < Uncomplete.length; i++) {
        isChanged[Uncomplete[i]] = prefs.getBool(Uncomplete[i]) ?? false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Uncomplete.length,
        itemBuilder: (context, index) {
          final String todoItem = Uncomplete[index];
          final bool isChecked = isChanged[todoItem] ?? false;

          return ListTile(
            leading: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  saveCheck(value!, todoItem);
                });
              },
            ),
            title: Text(
              todoItem,
              style: TextStyle(
                  decoration: (isChanged[todoItem] ?? false)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          );
        },
      ),
    );
  }
}
