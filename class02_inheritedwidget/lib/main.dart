import 'package:flutter/material.dart';

void main() {
  runApp(const testApp());
}

class testApp extends StatelessWidget {
  const testApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text("test")),
      body: const InheritedWidgetTestRoute(),
    ));
  }
}

class SharedDataWidget extends InheritedWidget {
  const SharedDataWidget({
    super.key,
    required this.child,
    required this.data,
  }) : super(child: child);
  final int data;
  final Widget child;

  static SharedDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedDataWidget>();
  }

  @override
  bool updateShouldNotify(SharedDataWidget old) {
    return old.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  const _TestWidget({super.key});

  @override
  State<_TestWidget> createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(SharedDataWidget.of(context)!.data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  const InheritedWidgetTestRoute({super.key});

  @override
  State<InheritedWidgetTestRoute> createState() =>
      _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  int i = 0;
  List list_data = ["apple", "banana", "grap", "dog"];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SharedDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: _TestWidget(),
            ),
            ElevatedButton(
                onPressed: () => setState(() {
                      ++count;
                      if (count == 5) {
                        if (i < (list_data.length - 1)) {
                          i += 1;
                        } else {
                          i = 0;
                        }
                        count = 0;
                      }
                    }),
                child: const Text("Increment")),
            Container(
              child: Text(list_data[i].toString()),
            )
          ],
        ),
      ),
    );
  }
}
