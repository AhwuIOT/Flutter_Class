import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class TimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 记录第一个操作的执行时间
    Timeline.timeSync('flow_test', () {
      doSomething();
      print("Hi1");
    });

    // 记录第二个操作的执行时间
    Timeline.timeSync('flow_test', () {
      doSomething();
      print("Hi2");
    });

    // 记录第三个操作的执行时间
    Timeline.timeSync('flow_test', () {
      doSomething();
      print("Hi3");
    });
    String x = "Hi4";
    return Container(
      child: Text(x),
    );
  }

  // 模拟一个耗时的操作
  void doSomething() {
    for (var i = 0; i < 1000000000; i++) {
      // 一些计算
    }
  }
}
