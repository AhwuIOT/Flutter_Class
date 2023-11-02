import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter計時器',
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
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _isActive = false;
  TextEditingController _hourController = TextEditingController();
  TextEditingController _minuteController = TextEditingController();
  TextEditingController _secondController = TextEditingController();
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter計時器'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('經過的時間: $_hours 小時 $_minutes 分 $_seconds 秒'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _hourController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '小時'),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _minuteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '分鐘'),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _secondController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '秒數'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int inputHours = int.tryParse(_hourController.text) ?? 0;
                  int inputMinutes = int.tryParse(_minuteController.text) ?? 0;
                  int inputSeconds = int.tryParse(_secondController.text) ?? 0;
                  _hours = inputHours;
                  _minutes = inputMinutes;
                  _seconds = inputSeconds;
                  _startTimer();
                });
              },
              child: Text('啟動'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _stopTimer();
                });
              },
              child: Text('停止'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _continueTimer();
                });
              },
              child: Text('繼續'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetTimer();
                });
              },
              child: Text('重置'),
            ),
            SizedBox(height: 20),
            _isActive
                ? Container() // 若計時器在運行，則不顯示打勾 ICON
                : _hours == 0 && _minutes == 0 && _seconds == 0
                    ? SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100,
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_hours == 0 && _minutes == 0 && _seconds == 0) {
          timer.cancel();
          _isActive = false;
        } else {
          if (_seconds == 0) {
            if (_minutes == 0) {
              if (_hours > 0) {
                _hours--;
                _minutes = 59;
                _seconds = 59;
              }
            } else {
              _minutes--;
              _seconds = 59;
            }
          } else {
            _seconds--;
          }
        }
      });
    });
    _isActive = true;
  }

  void _stopTimer() {
    _timer.cancel();
    _isActive = false;
  }

  void _continueTimer() {
    if (!_isActive) {
      _startTimer();
    }
  }

  void _resetTimer() {
    _timer.cancel();
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    _hourController.clear();
    _minuteController.clear();
    _secondController.clear();
  }
}
