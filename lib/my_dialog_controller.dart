import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MyDialogController extends GetxController {
  var data = ''.obs;
  late AudioPlayer player;

  @override
  void onInit() {
    debounce(data, (newData) {
      player = AudioPlayer()..setSourceAsset('audio/notification.mp3');
    });
    super.onInit();
  }

  Timer? timer;
  @override
  void onReady() {
    super.onReady();
    data.value = Get.arguments['data'];
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      data.value = DateTime.now().millisecondsSinceEpoch.toString();
    });
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    timer?.cancel();
    super.onClose();
  }
}
