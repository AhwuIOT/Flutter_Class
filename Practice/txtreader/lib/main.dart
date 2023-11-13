import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fileContent = '';
  int _bookmarkPosition = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadFile();
    _loadBookmark();
  }

  Future<void> _loadFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/assets/test.txt'); // 替換成你的文件路徑
    String fileContent = await file.readAsString();
    setState(() {
      _fileContent = fileContent;
    });
  }

  Future<void> _loadBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkPosition = prefs.getInt('bookmarkPosition') ?? 0;
      if (_bookmarkPosition != 0) {
        _scrollController.jumpTo(_bookmarkPosition.toDouble());
      }
    });
  }

  Future<void> _saveBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bookmarkPosition', _scrollController.offset.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Text Reader'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: _saveBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Text(_fileContent),
      ),
    );
  }
}
