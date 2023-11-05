import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flow Example')),
        body: FlowExample(),
      ),
    );
  }
}

class FlowExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      Container(width: 100, height: 100, color: Colors.red),
      Container(width: 100, height: 100, color: Colors.green),
      Container(width: 100, height: 100, color: Colors.blue),
      Container(width: 100, height: 100, color: Colors.yellow),
      Container(width: 100, height: 100, color: Colors.orange),
    ], spacing: 10.0, runSpacing: 10.0);
  }
}
