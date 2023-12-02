import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';

void main() async {
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

  Future<void> _saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String date = selectedDate?.toLocal().toString() ?? '';

    // 将isChecked转换为List<String>
    final List<String> boolListAsString =
        isChecked.map((value) => value ? '1' : '0').toList();

    // 将数据保存到SharedPreferences
    await prefs.setStringList(date, boolListAsString);
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String date = selectedDate?.toLocal().toString() ?? '';
    final List<String>? boolListAsString = prefs.getStringList(date);
    print("獲取時間$date");
    print("獲取過往資料$boolListAsString");
    if (boolListAsString != null) {
      // 将字符串列表转换为List<bool>
      final List<bool> loadedData = boolListAsString.map((value) {
        if (value == '1')
          return true;
        else
          return false;
      }).toList();

      setState(() {
        isChecked = loadedData;
      });
    } else {
      // 如果在SharedPreferences中找不到数据，可以设置默认的isChecked列表
      setState(() {
        isChecked = List.generate(24, (index) => false);
      });
    }
  }

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

      // 在selectedDate有值后再调用_loadData
      _loadData();
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
                            _saveData();
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
                _saveData();
                isChecked = List.generate(24, (index) => false);
              });
            },
            child: Text("Clean!")),
        // Text(isChecked.toString())
      ],
    );
  }
}
