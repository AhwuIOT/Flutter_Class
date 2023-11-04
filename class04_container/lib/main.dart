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
          body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          width: 200.0,
          height: 100.0,
          margin: EdgeInsets.all(8.0),
          transform: Matrix4.rotationZ(0.1),
          child: Text(
            'Container Example',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          clipBehavior: Clip.hardEdge,
        ),
      )),
    );
  }
}
