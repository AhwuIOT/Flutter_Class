import 'package:flutter/material.dart';

class FlowExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: MyFlowDelegate(), // 使用自定义的FlowDelegate
      children: <Widget>[
        Container(width: 100, height: 100, color: Colors.red),
        Container(width: 100, height: 100, color: Colors.green),
        Container(width: 100, height: 100, color: Colors.blue),
        Container(width: 100, height: 100, color: Colors.yellow),
        Container(width: 100, height: 100, color: Colors.orange),
      ],
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    // 实现子部件的排列逻辑
    // 这里可以根据需要自定义子部件的位置和大小
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          i * 110.0, // 每个子部件的水平间隔
          0.0, // 垂直位置，可以根据需要调整
          0.0, // Z轴偏移，通常设为0
        ),
      );
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // 判断是否需要重绘，通常返回false即可
    return false;
  }
}
