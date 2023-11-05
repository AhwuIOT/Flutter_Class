import 'package:flutter/material.dart';
import 'TimelineExample.dart';
import 'FlowExample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flow Example')),
        body: TimelineExample(),
      ),
    );
  }
}
