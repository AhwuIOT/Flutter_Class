import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';
import 'main.dart';

class todoComplete extends StatefulWidget {
  const todoComplete({
    super.key,
  });

  @override
  State<todoComplete> createState() => _todoCompleteState();
}

class _todoCompleteState extends State<todoComplete> {
  TaskStoreage task = TaskStoreage();

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      task.Complete = prefs.getStringList('Complete') ?? [];
      task.Uncomplete = prefs.getStringList('Uncomplete') ?? [];
      for (int i = 0; i < task.Uncomplete.length; i++) {
        task.isChanged[task.Uncomplete[i]] =
            prefs.getBool(task.Uncomplete[i]) ?? false;
      }
    });
  }

  Future<void> unDo(String unDodata) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (!task.Uncomplete.contains(unDodata)) task.Uncomplete.add(unDodata);
      if (task.Complete.contains(unDodata)) task.Complete.remove(unDodata);
      task.isChanged[unDodata] = false;
    });
    await prefs.setStringList('Complete', task.Complete);
    await prefs.setStringList('Uncomplete', task.Uncomplete);
    await prefs.setBool(unDodata, false);
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
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyApp()));
        },
      )),
      body: ListView.builder(
          itemCount: task.Complete.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                task.Complete[index],
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                unDo(task.Complete[index]);
              },
            );
          }),
    );
  }
}
