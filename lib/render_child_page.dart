import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderChildPage extends StatelessWidget {
  const RenderChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red[100],
        child: const ShadowBox(
          distance: 10,
          child: Icon(Icons.category, size: 120),
        ),
      ),
    );
  }
}

class ShadowBox extends SingleChildRenderObjectWidget {
  const ShadowBox({super.key, super.child, required this.distance});
  final double distance;
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShadowBox(distance);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderShadowBox renderObject) {
    renderObject.distance = distance;
  }
}

class RenderShadowBox extends RenderProxyBox with DebugOverflowIndicatorMixin {
  double distance;
  RenderShadowBox(this.distance);

  @override
  void performLayout() {
    child?.layout(
      constraints,
      parentUsesSize: true,
    );
    size = (child as RenderBox).size + Offset(distance, distance);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    context.paintChild(child!, offset);
    context.pushOpacity(
      offset + Offset(distance, distance),
      127,
      (context, offset) {
        context.paintChild(
          child!,
          offset,
        );
      },
    );
    paintOverflowIndicator(
      context,
      offset,
      Offset.zero & size,
      Offset.zero & child!.size,
    );
  }
}
