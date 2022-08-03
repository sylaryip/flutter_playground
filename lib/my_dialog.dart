import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_dialog_controller.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        color: Colors.white,
        child: GetX<MyDialogController>(
          init: MyDialogController(),
          builder: (state) {
            return Text(state.data.value);
          },
        ),
      ),
    );
  }
}
