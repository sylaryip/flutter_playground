import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/custom_paint_chaos.dart';
import 'package:playground/my_dialog.dart';
import 'package:playground/sketch_pad.dart';

import 'clock.dart';
import 'five_page.dart';
import 'home_page.dart';
import 'mixin/test.dart';
import 'skew_page.dart';
import 'stream_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}
