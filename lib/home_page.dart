import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'audio_page.dart';
import 'clock.dart';
import 'custom_paint_chaos.dart';
import 'five_page.dart';
import 'list_page.dart';
import 'mixin/test.dart';
import 'my_dialog.dart';
import 'sketch_pad.dart';
import 'skew_page.dart';
import 'stream_page.dart';
import 'value_notifier_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var test = Test();
          test.printState();
        },
      ),
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
              Get.to(() => const FivePage());
            },
          ),
          ListTile(
            title: const Text('Clock'),
            onTap: () async {
              Get.to(() => const ClockPage());
            },
          ),
          ListTile(
            title: const Text('Stream'),
            onTap: () async {
              Get.to(() => const StreamPage());
            },
          ),
          ListTile(
            title: const Text('List'),
            onTap: () async {
              Get.to(() => const ListPage());
            },
          ),
          ListTile(
            title: const Text('ValueNotifier'),
            onTap: () async {
              Get.to(() => const ValueNotifierPage());
            },
          ),
          ListTile(
            title: const Text('audio'),
            onTap: () async {
              Get.to(() => const AudioPage());
            },
          ),
        ],
      ),
    );
  }
}
