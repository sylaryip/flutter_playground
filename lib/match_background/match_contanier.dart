import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'dart:math' as math;
import 'match_container_controller.dart';
import 'match_title.dart';

enum Status {
  opened,
  closed,
  rotated,
}

class MatchContainer extends StatefulWidget {
  MatchContainer({
    super.key,
    double? offsetHeight,
    double? rotateHeight,
    this.controller,
    required this.centerTitle,
    required this.topTitle,
    required this.bottomTitle,
    required this.tipsMsg,
    this.rotatedChild,
  })  : offsetHeight = offsetHeight ?? 120.h,
        rotateHeight = rotateHeight ?? 500.h;
  final double offsetHeight;
  final double rotateHeight;
  final MatchContainerController? controller;
  final String centerTitle;
  final String topTitle;
  final String bottomTitle;
  final String tipsMsg;
  final Widget? rotatedChild;

  @override
  State<MatchContainer> createState() => _MatchContainerState();
}

class _MatchContainerState extends State<MatchContainer>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );
  late final AnimationController _titleController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final AnimationController _centerController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  final animateSliceValue = 0.600001;
  double get angle =>
      math.atan2(
        Get.height - widget.offsetHeight - widget.offsetHeight,
        -Get.width,
      ) -
      math.pi;

  double get rotateAngle =>
      math.atan2(
          Get.height - widget.offsetHeight - widget.rotateHeight, -Get.width) -
      math.pi;

  Status get status {
    if (_controller.value == 0 || _controller.value == animateSliceValue) {
      return Status.closed;
    } else if (_controller.value <= 0.6) {
      return Status.opened;
    } else if (_controller.value > 0.6) {
      return Status.rotated;
    }
    return Status.closed;
  }

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      widget.controller!
        ..open = open
        ..close = close
        ..rotate = rotate
        ..rotateBack = rotateBack;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _centerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFFF6B31),
                Color(0xFFFFC500),
              ],
            )),
          ),
          _buildTop(),
          _buildBottom(),
          _buildCenter(),
          _buildTipsMsg(),
          if (widget.rotatedChild != null)
            Positioned(
              bottom: 0,
              child: SizedBox(
                  height: widget.rotateHeight - 50.w,
                  width: Get.width,
                  child: widget.rotatedChild!),
            ),
        ],
      ),
    );
  }

  Widget _buildTipsMsg() {
    return Positioned(
      right: 15.w,
      top: widget.offsetHeight + 80.w,
      child: AnimatedBuilder(
        animation: _controller,
        builder: ((context, child) {
          return Opacity(
            opacity: status == Status.rotated
                ? Tween<double>(begin: 0, end: 1)
                    .chain(CurveTween(curve: const Interval(0.8, 1.0)))
                    .animate(_controller)
                    .value
                : 0,
            child: child,
          );
        }),
        child: Transform.rotate(
          angle: rotateAngle,
          child: Text(
            widget.tipsMsg,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenter() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            alignment: Tween<Alignment>(
                    begin: Alignment.center, end: const Alignment(1.2, -.57))
                .chain(CurveTween(curve: const Interval(.6, 1.0)))
                .animate(_controller)
                .value,
            transform: Matrix4.identity()
              ..rotateZ(Tween<double>(begin: angle, end: rotateAngle)
                  .chain(CurveTween(curve: const Interval(.6, 1.0)))
                  .animate(_controller)
                  .value),
            transformAlignment: Alignment.center,
            child: AnimatedBuilder(
                animation: _centerController,
                builder: (context, _) {
                  return Transform.scale(
                    scale: Tween<double>(begin: 1, end: 0)
                        .chain(CurveTween(curve: const Interval(.2, 1)))
                        .chain(CurveTween(curve: Curves.bounceIn))
                        .animate(_centerController)
                        .value,
                    child: Container(
                      transformAlignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xFF263073),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x66FFFFFF),
                                offset: Offset(8.w, 8.w))
                          ]),
                      child: Text(widget.centerTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  );
                }),
          );
        });
  }

  Widget _buildBottom() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: status == Status.opened
              ? Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(135.0, widget.offsetHeight),
                )
                  .chain(CurveTween(curve: const Interval(.3, .6)))
                  .animate(_controller)
                  .value
              : Offset.zero,
          child: Transform.scale(
              scale: 1.25,
              child: ClipPath(
                clipper: BottomRightClipper(
                  status == Status.rotated
                      ? Tween<double>(
                          begin: -widget.offsetHeight,
                          end: -widget.rotateHeight,
                        )
                          .chain(CurveTween(curve: const Interval(.6, 1.0)))
                          .animate(_controller)
                          .value
                      : -widget.offsetHeight,
                  widget.offsetHeight,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFD10FAF),
                      Color(0xFFF90074),
                    ],
                  )),
                  child: _bottomTitle(),
                ),
              )),
        );
      },
    );
  }

  Widget _bottomTitle() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            alignment: Tween<Alignment>(
                    begin: Alignment.center, end: const Alignment(-3.0, -0.85))
                .chain(CurveTween(curve: const Interval(.62, 1.0)))
                .animate(_controller)
                .value,
            transform: Matrix4.translationValues(35.w, 135.w, 0)..scale(0.75),
            transformAlignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _titleController,
              builder: (context, child) {
                return (Transform.scale(
                  scale: Tween<double>(begin: 1, end: 0)
                      .chain(CurveTween(curve: Curves.bounceIn))
                      .animate(_titleController)
                      .value,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(Tween<double>(begin: angle, end: rotateAngle)
                          .chain(CurveTween(curve: const Interval(.62, 1.0)))
                          .animate(_controller)
                          .value)
                      ..scale(Tween<double>(begin: 1, end: 0.75)
                          .chain(CurveTween(curve: const Interval(.62, 1.0)))
                          .animate(_controller)
                          .value),
                    alignment: Alignment.center,
                    child: MatchTitle(content: widget.bottomTitle),
                  ),
                ));
              },
            ),
          );
        });
  }

  Widget _buildTop() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: status == Status.opened
                ? Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(-135.0, -widget.offsetHeight),
                  )
                    .chain(CurveTween(curve: const Interval(.3, .6)))
                    .animate(_controller)
                    .value
                : Offset.zero, // Offset(-135, -100),
            child: Transform.scale(
              scale: 1.25,
              child: ClipPath(
                clipper:
                    TopLeftClipper(-widget.offsetHeight, widget.offsetHeight),
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF104B9C),
                        Color(0xFF47C3EF),
                      ],
                    )),
                    child: _topTitle()),
              ),
            ),
          );
        });
  }

  Widget _topTitle() {
    return AnimatedBuilder(
      animation: _titleController,
      builder: (context, child) {
        return Container(
            alignment: Tween<Alignment>(
                    begin: Alignment.center, end: const Alignment(0, -.35))
                .chain(CurveTween(curve: const Interval(.62, 1.0)))
                .animate(_controller)
                .value,
            transform: Matrix4.translationValues(-35.w, -130.w, 0)..scale(0.75),
            transformAlignment: Alignment.center,
            child: Transform.scale(
              scale: Tween<double>(begin: 1, end: 0)
                  .chain(CurveTween(curve: Curves.bounceIn))
                  .animate(_titleController)
                  .value,
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateZ(Tween<double>(begin: angle, end: rotateAngle)
                      .chain(CurveTween(curve: const Interval(.62, 1.0)))
                      .animate(_controller)
                      .value)
                  ..scale(Tween<double>(begin: 1, end: 0.5)
                      .chain(CurveTween(curve: const Interval(.62, 1.0)))
                      .animate(_controller)
                      .value),
                alignment: Alignment.center,
                child: MatchTitle(content: widget.topTitle),
              ),
            ));
      },
    );
  }

  void showCenter() {
    _centerController.animateBack(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  void hideCenter() {
    _centerController
      ..reset()
      ..forward();
  }

  void open() {
    _titleController.forward();
    hideCenter();
    _controller
      ..reset()
      ..animateTo(0.6);
  }

  void close() {
    showCenter();
    _controller.reverse(from: 0.6);
    _titleController.animateBack(0, duration: Duration.zero);
  }

  void rotate() {
    _controller
      ..reset()
      ..forward(from: animateSliceValue);
    setState(() {});
  }

  void rotateBack() {
    _controller
      ..forward(from: 1)
      ..animateBack(animateSliceValue);
    setState(() {});
  }
}

class TopLeftClipper extends CustomClipper<Path> {
  final double leftHeight;
  final double rightHeight;
  TopLeftClipper(this.leftHeight, this.rightHeight);

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, rightHeight)
      ..lineTo(0.0, size.height + leftHeight)
      ..lineTo(0.0, 0.0)
      ..lineTo(size.width, 0.0)
      ..close();
  }

  @override
  bool shouldReclip(TopLeftClipper oldClipper) =>
      oldClipper.leftHeight != leftHeight ||
      oldClipper.rightHeight != rightHeight;
}

class BottomRightClipper extends CustomClipper<Path> {
  final double leftHeight;
  final double rightHeight;
  BottomRightClipper(this.leftHeight, this.rightHeight);

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0.0, size.height + leftHeight)
      ..lineTo(size.width, rightHeight)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(BottomRightClipper oldClipper) =>
      oldClipper.leftHeight != leftHeight ||
      oldClipper.rightHeight != rightHeight;
}
