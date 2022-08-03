import 'package:flutter/material.dart';

class SkewPage extends StatefulWidget {
  const SkewPage({Key? key}) : super(key: key);

  @override
  State<SkewPage> createState() => _SkewPageState();
}

class _SkewPageState extends State<SkewPage> {
  Offset _offset = Offset.zero;
  double _zOffset = 0;
  double _scale = 0.9999;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        // onHorizontalDragUpdate: (DragUpdateDetails details) =>
        //     setState(() => _zOffset += details.delta.dx),
        // onVerticalDragUpdate: (DragUpdateDetails details) =>
        //     setState(() => _scale += 0.001 * details.delta.dy),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue[100],
            child: Stack(
              children: [
                Center(
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.01 * _offset.dy)
                      ..rotateY(-0.01 * _offset.dx)
                      ..rotateZ(0.01 * _zOffset)
                      ..scale(_scale),
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
                ),
                Text('rotateX:${0.01 * _offset.dy}\n'
                    'rotateY:${-0.01 * _offset.dx}\n'
                    'rotateZ:${0.01 * _zOffset}\n'
                    'Scale:$_scale\n'),
                Positioned(
                  bottom: 0,
                  child: Container(
                      width: double.infinity, height: 30, color: Colors.red),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                      width: 30, height: double.infinity, color: Colors.red),
                )
              ],
            )),
      ),
    );
  }
}
