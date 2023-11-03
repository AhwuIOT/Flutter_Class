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

class TimerItem {
  int hours;
  int minutes;
  int seconds;
  bool isActive;
  TextEditingController hourController;
  TextEditingController minuteController;
  TextEditingController secondController;
  Timer? timer;

  TimerItem({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.isActive = false,
    TextEditingController? hourController,
    TextEditingController? minuteController,
    TextEditingController? secondController,
  })  : hourController = hourController ?? TextEditingController(),
        minuteController = minuteController ?? TextEditingController(),
        secondController = secondController ?? TextEditingController();

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      // Timer tick update logic will be added here
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
      isActive = false;
    }
  }

  void resetTimer() {
    stopTimer();
    hours = 0;
    minutes = 0;
    seconds = 0;
    hourController.clear();
    minuteController.clear();
    secondController.clear();
  }

  // Other methods like continueTimer will be added here if needed
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  List<TimerItem> timers = [];
  double _timerfontsize = 30.0;
  bool changeFontSize = false;
  @override
  void dispose() {
    for (var timerItem in timers) {
      timerItem.stopTimer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Dynamic Timers'),
        // ),
        body: ListView.builder(
          itemCount: timers.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // 在此处计算字体大小，例如基于容器的宽度和高度
                        double fontSize =
                            constraints.maxWidth / 5.0; // 调整这个比例以满足您的需求

                        return Text(
                          '${timers[index].hours}:${timers[index].minutes}:${timers[index].seconds}',
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold), // 使用计算的字体大小
                        );
                      },
                    ),
                    Visibility(
                        visible: !timers[index].isActive,
                        maintainSize: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                controller: timers[index].hourController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(labelText: '小時'),
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                controller: timers[index].minuteController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(labelText: '分鐘'),
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                controller: timers[index].secondController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(labelText: '秒數'),
                              ),
                            ),
                            Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        timers[index].hours = int.tryParse(
                                                timers[index]
                                                    .hourController
                                                    .text) ??
                                            0;
                                        timers[index].minutes = int.tryParse(
                                                timers[index]
                                                    .minuteController
                                                    .text) ??
                                            0;
                                        timers[index].seconds = int.tryParse(
                                                timers[index]
                                                    .secondController
                                                    .text) ??
                                            0;
                                        timers[index].isActive = true;
                                        _changeFontSize(timers[index]);
                                      });
                                    },
                                    child: Text("SetTimer")),
                                TextButton(
                                  onPressed: () => _resetTimer(timers[index]),
                                  child: Text('Reset'),
                                ),
                              ],
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () => _startTimer(timers[index]),
                                    child: Text('Start'),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          timers.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.delete)),
                                ]),
                          ],
                        )),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTimer,
          tooltip: 'Add Timer',
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  for (var i = 0; i < timers.length; i++) {
                    _startTimer(timers[i]);
                  }
                });
              },
              child: Text('Start All'),
            ),

            // SizedBox(
            //   width: 50,
            // ),
            TextButton(
              onPressed: () {
                setState(() {
                  for (var i = 0; i < timers.length; i++) {
                    _stopTimer(timers[i]);
                  }
                });
              },
              child: Text('Stop'),
            ),
          ],
        ));
  }

  void addTimer() {
    setState(() {
      timers.add(TimerItem());
    });
  }

  void _startTimer(TimerItem timerItem) {
    const oneSec = Duration(seconds: 1);
    timerItem.timer = Timer.periodic(oneSec, (Timer timer) {
      if (timerItem.hours == 0 &&
          timerItem.minutes == 0 &&
          timerItem.seconds == 0) {
        timer.cancel();
        timerItem.isActive = false;
      } else {
        setState(() {
          if (timerItem.seconds == 0) {
            if (timerItem.minutes == 0) {
              if (timerItem.hours > 0) {
                timerItem.hours--;
                timerItem.minutes = 59;
                timerItem.seconds = 59;
              }
            } else {
              timerItem.minutes--;
              timerItem.seconds = 59;
            }
          } else {
            timerItem.seconds--;
          }
        });
      }
    });
    timerItem.isActive = true;
  }

  void _stopTimer(TimerItem timerItem) {
    if (timerItem.timer?.isActive ?? false) {
      timerItem.timer?.cancel();
      timerItem.isActive = false;
    }
  }

  void _resetTimer(TimerItem timerItem) {
    setState(() {
      timerItem.resetTimer();
    });
  }

  void _changeFontSize(TimerItem timerItem) {
    if (timerItem.isActive == true) {
      _timerfontsize = 60.0;
    }
  }

  // ... other methods such as _continueTimer will be updated similarly
}
