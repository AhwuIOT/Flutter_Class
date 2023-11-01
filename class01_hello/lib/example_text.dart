import 'package:flutter/material.dart';

class example_text extends StatelessWidget {
  const example_text({
    super.key,
  });
  final Color accentColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Hello World",
      textDirection: TextDirection.ltr,
      style: TextStyle(
        //顏色
        color: accentColor,
        //大小
        fontSize: 30,
        //粗體
        fontWeight: FontWeight.w500,
        //斜體
        fontStyle: FontStyle.italic,
        //字間距
        letterSpacing: 5.0,
        //單辭間距
        wordSpacing: 5.0,
        height: 2,
        shadows: [
          Shadow(color: Colors.white, offset: Offset(2, 2), blurRadius: 3)
        ],
        background: Paint()..color = Color.fromARGB(255, 200, 230, 249),
      ),
    ));
  }
}
