import 'package:flutter/material.dart';

class TapRegionPage extends StatefulWidget {
  const TapRegionPage({super.key});

  @override
  State<TapRegionPage> createState() => _TapRegionPageState();
}

class _TapRegionPageState extends State<TapRegionPage> {
  // final FocusScopeNode _node = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    // 3.3.10
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Center(
    //       child: FocusTrap(
    //     focusScopeNode: _node,
    //     child: buildAWidget(),
    //   )),
    // );

    // 3.7.7
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: TapRegion(
              onTapOutside: (event) {
                print(event);
              },
              child: buildAWidget()),
        ));
  }

  Widget buildAWidget() {
    return Container(
      color: Colors.red,
      height: 20,
      width: 20,
    );
  }
}
