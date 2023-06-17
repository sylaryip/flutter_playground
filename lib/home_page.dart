import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/dio_page.dart';
import 'package:playground/getx_test_page.dart';
import 'package:playground/inkwell_page.dart';
import 'package:playground/listview_position.dart';
import 'package:playground/queue_page.dart';
import 'package:playground/tabview_page.dart';
import 'package:playground/tap_region.dart';

import 'audio_page.dart';
import 'autocomplete.dart';
import 'clock.dart';
import 'custom_paint_chaos.dart';
import 'expand_test.dart';
import 'five_page.dart';
import 'getx_test_controller.dart';
import 'image_center_slice_page.dart';
import 'list_page.dart';
import 'mixin/test.dart';
import 'my_dialog.dart';
import 'processbar.dart';
import 'render_child_page.dart';
import 'sketch_pad.dart';
import 'skew_page.dart';
import 'stream_page.dart';
import 'value_notifier_page.dart';
import 'widgets/game_page.dart';

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
            title: const Text('tabViewPage'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TabViewPage(),
              ));
            },
          ),
          ListTile(
            title: const Text('TapRegionPage'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TapRegionPage(),
              ));
            },
          ),
          ListTile(
            title: const Text('inkwell'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InkWellPage(),
              ));
            },
          ),
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
          ListTile(
            title: const Text('autocomplete'),
            onTap: () async {
              Get.to(() => const AutoCompletePage());
            },
          ),
          ListTile(
            title: const Text('image centerSlice'),
            onTap: () async {
              Get.to(() => const ImageCenterSlicePage());
            },
          ),
          ListTile(
            title: const Text('render child'),
            onTap: () async {
              Get.to(() => const RenderChildPage());
            },
          ),
          ListTile(
            title: const Text('expand test'),
            onTap: () async {
              Get.to(() => const ExpandTestPage());
            },
          ),
          ListTile(
            title: const Text('xie'),
            onTap: () async {
              Get.to(() => const GamePage());
            },
          ),
          ListTile(
            title: const Text('ProcessBarPage'),
            onTap: () async {
              Get.to(() => const ProcessBarPage());
            },
          ),
          ListTile(
            title: const Text('ListView position'),
            onTap: () async {
              Get.to(() => const ListViewPosition());
            },
          ),
          ListTile(
            title: const Text('dio'),
            onTap: () async {
              Get.to(() => const DioPage());
            },
          ),
          ListTile(
            title: const Text('queue'),
            onTap: () async {
              Get.to(() => const QueuePage());
            },
          ),
          ListTile(
            title: const Text('GetXBuilder'),
            onTap: () async {
              var tag = UniqueKey().toString();
              var controller = GetXTestController();
              controller.myValue = 10;
              Get.to(
                () => GetXTestPage(tag: tag),
                binding: BindingsBuilder.put(
                  () => controller,
                  tag: tag,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
