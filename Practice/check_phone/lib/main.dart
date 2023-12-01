import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('手機歸還CheckList'),
        ),
        body: Center(
          child: Check_box(),
        ),
      ),
    );
  }
}

class Check_box extends StatefulWidget {
  Check_box({super.key});

  @override
  State<Check_box> createState() => _Check_boxState();
}

class _Check_boxState extends State<Check_box> {
  List<bool> isChecked = List.generate(24, (index) => false);
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select Date'),
        ),
        selectedDate != null
            ? Text('Selected Date: ${selectedDate!.toLocal()}'.split(' ')[0])
            : Text('No date selected'),
        Expanded(
          child: ListView(
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(24, (index) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListTile(
                      trailing: isChecked[index]
                          ? Icon(Icons.sentiment_very_dissatisfied,
                              color: Colors.red)
                          : Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.blue,
                            ),
                      title: Text(
                        (index + 1).toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: Checkbox(
                        value: isChecked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked[index] = value!;
                          });
                        },
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                isChecked = List.generate(24, (index) => false);
              });
            },
            child: Text("Clean!"))
      ],
    );
  }
}
