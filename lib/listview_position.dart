import 'package:flutter/material.dart';

class ListViewPosition extends StatelessWidget {
  const ListViewPosition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.red,
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: <Widget>[
            ListView.builder(
              physics: NoBouncingScrollPhysics(),
              itemCount: 50,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              padding: const EdgeInsets.only(bottom: 60),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: Colors.transparent,
                child: Center(
                  child: Text('Floating Widget'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoBouncingScrollPhysics extends ScrollPhysics {
  @override
  NoBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return NoBouncingScrollPhysics();
  }

  @override
  double applyBoundaryConditions(ScrollMetrics metrics, double value) {
    return 1.0;
  }
}
