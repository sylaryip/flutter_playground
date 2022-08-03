import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/custom_paint_chaos.dart';
import 'package:playground/my_dialog.dart';
import 'package:playground/my_dialog_controller.dart';
import 'package:playground/sketch_pad.dart';

import 'five_page.dart';
import 'skew_page.dart';

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

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Sketch Pad'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SketchPad(),
              ));
            },
          ),
          ListTile(
            title: const Text('Chaos'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CustomPaintChaos(),
              ));
            },
          ),
          ListTile(
            title: const Text('Skew'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SkewPage(),
              ));
            },
          ),
          ListTile(
            title: const Text('GetDialog'),
            onTap: () async {
              // Get.put<MyDialogController>(MyDialogController());
              Get.dialog(const MyDialog(), arguments: {'data': 'hahaha'});
              // Get.delete<MyDialogController>();
            },
          ),
          ListTile(
            title: const Text('Five'),
            onTap: () async {
              Get.to(const FivePage());
            },
          ),
        ],
      ),
    );
  }
}
