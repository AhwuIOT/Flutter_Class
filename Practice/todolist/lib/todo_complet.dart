import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class todoComplete extends StatefulWidget {
  const todoComplete({
    super.key,
  });

  @override
  State<todoComplete> createState() => _todoCompleteState();
}

class _todoCompleteState extends State<todoComplete> {
  Map<String, bool> isChanged = {};
  List<String> Uncomplete = [];
  List<String> Complete = [];
  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      Complete = prefs.getStringList('Complete') ?? [];
      Uncomplete = prefs.getStringList('Uncomplete') ?? [];
      Uncomplete.forEach((element) {
        isChanged[element] = prefs.getBool(element) ?? false;
      });
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
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: ListView.builder(
          itemCount: Complete.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                Complete[index],
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            );
          }),
    );
  }
}
