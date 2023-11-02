import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter多個計數器',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerApp(),
    );
  }
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  int _hours1 = 0;
  int _minutes1 = 0;
  int _seconds1 = 0;
  bool _isActive1 = false;
  int _hours2 = 0;
  int _minutes2 = 0;
  int _seconds2 = 0;
  bool _isActive2 = false;
  TextEditingController _hourController1 = TextEditingController();
  TextEditingController _minuteController1 = TextEditingController();
  TextEditingController _secondController1 = TextEditingController();
  TextEditingController _hourController2 = TextEditingController();
  TextEditingController _minuteController2 = TextEditingController();
  TextEditingController _secondController2 = TextEditingController();
  late Timer _timer1;
  late Timer _timer2;

  @override
  void dispose() {
    _timer1.cancel();
    _timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter多個計數器'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 計數器1
            Text('計數器1: $_hours1 小時 $_minutes1 分 $_seconds1 秒'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _hourController1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '小時'),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _minuteController1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '分鐘'),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _secondController1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '秒數'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _resetTimer1();
                    });
                  },
                  child: Text('重置計數器1'),
                )
              ],
            ),

            // 計數器2
            Text('計數器2: $_hours2 小時 $_minutes2 分 $_seconds2 秒'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _hourController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '小時'),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _minuteController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '分鐘'),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _secondController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '秒數'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _resetTimer2();
                    });
                  },
                  child: Text('重置計數器2'),
                )
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int inputHours1 = int.tryParse(_hourController1.text) ?? 0;
                  int inputMinutes1 =
                      int.tryParse(_minuteController1.text) ?? 0;
                  int inputSeconds1 =
                      int.tryParse(_secondController1.text) ?? 0;
                  int inputHours2 = int.tryParse(_hourController2.text) ?? 0;
                  int inputMinutes2 =
                      int.tryParse(_minuteController2.text) ?? 0;
                  int inputSeconds2 =
                      int.tryParse(_secondController2.text) ?? 0;
                  _hours1 = inputHours1;
                  _minutes1 = inputMinutes1;
                  _seconds1 = inputSeconds1;
                  _hours2 = inputHours2;
                  _minutes2 = inputMinutes2;
                  _seconds2 = inputSeconds2;
                  _startTimer();
                });
              },
              child: Text('啟動計數器1和計數器2'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _stopTimer();
                });
              },
              child: Text('停止計數器1和計數器2'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _continueTimer();
                });
              },
              child: Text('繼續計數器1和計數器2'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer1 = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_hours1 == 0 && _minutes1 == 0 && _seconds1 == 0) {
          timer.cancel();
          _isActive1 = false;
        } else {
          if (_seconds1 == 0) {
            if (_minutes1 == 0) {
              if (_hours1 > 0) {
                _hours1--;
                _minutes1 = 59;
                _seconds1 = 59;
              }
            } else {
              _minutes1--;
              _seconds1 = 59;
            }
          } else {
            _seconds1--;
          }
        }
      });
    });
    _isActive1 = true;

    _timer2 = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_hours2 == 0 && _minutes2 == 0 && _seconds2 == 0) {
          timer.cancel();
          _isActive2 = false;
        } else {
          if (_seconds2 == 0) {
            if (_minutes2 == 0) {
              if (_hours2 > 0) {
                _hours2--;
                _minutes2 = 59;
                _seconds2 = 59;
              }
            } else {
              _minutes2--;
              _seconds2 = 59;
            }
          } else {
            _seconds2--;
          }
        }
      });
    });
    _isActive2 = true;
  }

  void _stopTimer() {
    _timer1.cancel();
    _timer2.cancel();
    _isActive1 = false;
    _isActive2 = false;
  }

  void _continueTimer() {
    if (!_isActive1 || !_isActive2) {
      _startTimer();
    }
  }

  void _resetTimer1() {
    _timer1.cancel();
    _hours1 = 0;
    _minutes1 = 0;
    _seconds1 = 0;
    _hourController1.clear();
    _minuteController1.clear();
    _secondController1.clear();
  }

  void _resetTimer2() {
    _timer2.cancel();
    _hours2 = 0;
    _minutes2 = 0;
    _seconds2 = 0;
    _hourController2.clear();
    _minuteController2.clear();
    _secondController2.clear();
  }
}
