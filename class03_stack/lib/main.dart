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
            body: SafeArea(
      child: Stack(
        alignment: Alignment.center, // 子小部件在Stack中居中對齊
        fit: StackFit.expand, // 子小部件佔滿Stack區域
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            color: Colors.blue,
          ),
          Positioned(
            top: 150,
            left: 150,
            child: Text(
              'First',
              style: TextStyle(fontSize: 100),
            ),
          ),
          Positioned(
            top: 200,
            left: 200,
            child: Text(
              'Second',
              style: TextStyle(fontSize: 100),
            ),
          )
        ], // 文本方向從左到右))
      ),
    )));
  }
}
