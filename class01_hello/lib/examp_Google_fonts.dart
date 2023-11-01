import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'example_simple.dart';
import 'example_font_selection.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      home: DefaultTabController(
        animationDuration: Duration.zero,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Google Fonts Demo'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: 'Simple'),
                Tab(text: 'Select a font'),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[ExampleSimple(), ExampleFontSelection()],
          ),
        ),
      ),
    );
  }
}
