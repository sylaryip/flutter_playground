import 'dart:math';
import 'package:flutter/material.dart';

class SkewPage extends StatefulWidget {
  const SkewPage({Key? key}) : super(key: key);

  @override
  State<SkewPage> createState() => _SkewPageState();
}

class _SkewPageState extends State<SkewPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(vsync: this);
  Offset _offset = Offset.zero;
  double _zOffset = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) =>
            setState(() => _zOffset += details.delta.dx),
        child: Container(
            color: Colors.blue[100],
            alignment: Alignment.center,
            child: Stack(
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(0.01 * _offset.dy)
                    ..rotateY(-0.01 * _offset.dx)
                    ..rotateZ(0.01 * _zOffset),
                  alignment: FractionalOffset.center,
                  child: GestureDetector(
                    onPanUpdate: (details) =>
                        setState(() => _offset += details.delta),
                    onDoubleTap: () => setState(() {
                      _offset = Offset.zero;
                      _zOffset = 0;
                    }),
                    child: Container(
                        alignment: Alignment.center,
                        height: 300,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const FlutterLogo()),
                  ),
                ),
                Text('rotateX:${0.01 * _offset.dy}\n'
                    'rotateY:${-0.01 * _offset.dx}\n'
                    'rotateZ:${0.01 * _zOffset}'),
              ],
            )),
      ),
    );
  }
}
