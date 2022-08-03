import 'package:get/get.dart';

class MyDialogController extends GetxController {
  var data = ''.obs;

  @override
  void onReady() {
    super.onReady();
    data.value = Get.arguments['data'];
  }
}
