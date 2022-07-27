import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintChaos extends StatefulWidget {
  const CustomPaintChaos({Key? key}) : super(key: key);

  @override
  State<CustomPaintChaos> createState() => _CustomPaintChaosState();
}

class _CustomPaintChaosState extends State<CustomPaintChaos> {
  final List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        body: RepaintBoundary(
          child: CustomPaint(
            foregroundPainter: ChaosPainter(),
            child: Container(color: Colors.yellow[100]),
          ),
        ),
      ),
    );
  }
}

class ChaosPainter extends CustomPainter {
  final rand = Random();
  final pen = Paint()..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    final anchors = [
      Offset(size.width / 2, 0),
      Offset(0, size.height),
      Offset(size.width, size.height)
    ];

    Offset current = const Offset(0, 0);
    for (int i = 0; i < 50000; i++) {
      final anchor = anchors[rand.nextInt(anchors.length)];
      current = (current + anchor) / 2;
      if (i > 10) canvas.drawCircle(current, 1.0, pen);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
