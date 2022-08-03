import 'dart:math';

import 'package:flutter/material.dart';

class FivePage extends StatelessWidget {
  const FivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CustomPaint(
      painter: PentagonPainter(),
    )));
  }
}

class PentagonPainter extends CustomPainter {
  Offset getPoint1(double r, int i, int n) => Offset(0, -r * (i + 1) / n);
  Offset getPoint2(double r, int i, int n) => Offset(
      r * (i + 1) / n * cos(angleToRadian(18)),
      -r * (i + 1) / n * sin(angleToRadian(18)));
  Offset getPoint3(double r, int i, int n) => Offset(
      r * (i + 1) / n * cos(angleToRadian(54)),
      r * (i + 1) / n * sin(angleToRadian(54)));
  Offset getPoint4(double r, int i, int n) => Offset(
      -r * (i + 1) / n * cos(angleToRadian(54)),
      r * (i + 1) / n * sin(angleToRadian(54)));
  Offset getPoint5(double r, int i, int n) => Offset(
      -r * (i + 1) / n * cos(angleToRadian(18)),
      r * (i + 1) / n * -sin(angleToRadian(18)));

  @override
  void paint(Canvas canvas, Size size) {
    Paint pentagonPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.25
      ..style = PaintingStyle.stroke;

    var n = 4;
    var r = 212.0;
    for (int i = 0; i < n; i++) {
      List<Offset> points = [
        getPoint1(r, i, n),
        getPoint2(r, i, n),
        getPoint3(r, i, n),
        getPoint4(r, i, n),
        getPoint5(r, i, n),
      ];
      drawPentagon(points, canvas, pentagonPaint);
    }
    canvas.drawLine(
      getPoint1(r, 0, n),
      getPoint1(r, 3, n),
      pentagonPaint,
    );
    drawText(
        canvas,
        getPoint1(r, 3, n) - const Offset(0, 25),
        'point1',
        const TextStyle(fontSize: 14, color: Colors.black54),
        MoveType.halfMove);
    canvas.drawLine(
      getPoint2(r, 0, n),
      getPoint2(r, 3, n),
      pentagonPaint,
    );
    drawText(
      canvas,
      getPoint2(r, 3, n) + const Offset(10, -15),
      'point2',
      const TextStyle(fontSize: 14, color: Colors.black54),
      MoveType.noMove,
    );
    canvas.drawLine(
      getPoint3(r, 0, n),
      getPoint3(r, 3, n),
      pentagonPaint,
    );
    drawText(
      canvas,
      getPoint3(r, 3, n) + const Offset(0, 10),
      'point3',
      const TextStyle(fontSize: 14, color: Colors.black54),
      MoveType.halfMove,
    );
    canvas.drawLine(
      getPoint4(r, 0, n),
      getPoint4(r, 3, n),
      pentagonPaint,
    );
    drawText(
      canvas,
      getPoint4(r, 3, n) + const Offset(0, 10),
      'point4',
      const TextStyle(fontSize: 14, color: Colors.black54),
      MoveType.halfMove,
    );
    canvas.drawLine(
      getPoint5(r, 0, n),
      getPoint5(r, 3, n),
      pentagonPaint,
    );
    drawText(
      canvas,
      getPoint5(r, 3, n) + const Offset(-10, -15),
      'point5',
      const TextStyle(fontSize: 14, color: Colors.black54),
      MoveType.allMove,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawPentagon(List<Offset> points, Canvas canvas, Paint paint) {
    if (points.isEmpty) {
      return;
    }
    Path path = Path();

    path.moveTo(0, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double angleToRadian(double angle) {
    return angle / 180.0 * pi;
  }

  void drawText(Canvas canvas, Offset offset, String text, TextStyle style,
      MoveType type) {
    var textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl);
    textPainter.layout();
    Size size = textPainter.size;
    Offset offsetResult;
    switch (type) {
      case MoveType.halfMove:
        offsetResult = Offset(offset.dx - size.width / 2, offset.dy);
        break;
      case MoveType.allMove:
        offsetResult = Offset(offset.dx - size.width, offset.dy);
        break;
      default:
        offsetResult = offset;
    }
    textPainter.paint(canvas, offsetResult);
  }
}

enum MoveType { noMove, halfMove, allMove }
