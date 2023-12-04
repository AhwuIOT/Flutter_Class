import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:html/parser.dart';

void main() async {
  var url = Uri.parse('https://tw.stock.yahoo.com/quote/2330');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print('请求成功');
    var document = parse(response.body);
    var title = document.querySelector('h1')?.text;
    print('找到标题:$title');
  } else {
    print('请求失败，状态码：${response.statusCode}');
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
