import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/getx_test_controller.dart';

class GetXTestPage extends StatelessWidget {
  const GetXTestPage({super.key, this.tag});
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<GetXTestController>(
        init: GetXTestController(),
        tag: tag,
        builder: (logic) {
          return Center(child: Text('${logic.myValue}'));
        },
      ),
    );
  }
}
