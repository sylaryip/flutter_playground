import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InkWellPage extends StatefulWidget {
  const InkWellPage({super.key});

  @override
  State<InkWellPage> createState() => _InkWellPageState();
}

class _InkWellPageState extends State<InkWellPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 360));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.reset();
            _controller.forward();
          },
        ),
        body: Stack(
          children: [
            Positioned(
              left: Get.width - 142,
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 45,
                child: Row(
                  children: [
                    Container(height: 10, width: 10, color: Colors.white),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                            alignment: Alignment.center,
                            width: Tween(begin: 0.0, end: 100.0)
                                .animate(_controller)
                                .value,
                            child: Text(
                              'abcdefg',
                              maxLines: 1,
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                color: Colors.green.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 45,
                child: Row(
                  children: [
                    Container(height: 10, width: 10, color: Colors.white),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                            alignment: Alignment.center,
                            width: Tween(begin: 0.0, end: 100.0)
                                .animate(_controller)
                                .value,
                            child: const Text(
                              'abcdefg',
                              maxLines: 1,
                            ));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
