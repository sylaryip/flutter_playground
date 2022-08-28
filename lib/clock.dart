import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 300,
          height: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: CustomPaint(
            painter: ClockPainter(
              radius: 120,
            ),
          )),
    );
  }
}

class ClockPainter extends CustomPainter {
  final double radius;
  ClockPainter({required this.radius});

  final paint1 = Paint()
    ..color = Colors.black
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset.zero,
        radius,
        Paint()
          ..color = Colors.orange
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
    canvas.drawPoints(
        PointMode.polygon,
        List.generate(
            360,
            (index) =>
                pointOffset(radius + Random().nextInt(100), index.toDouble())),
        paint1);
  }

  Offset pointOffset(double radius, double angle) {
    return Offset(
      radius * cos(degToRad(angle)),
      radius * sin(degToRad(angle)),
    );
  }

  num degToRad(num deg) => deg * (pi / 180.0);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
