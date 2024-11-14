import 'package:get/get.dart';
import 'package:spotify/view/verif/controller.dart';

class VerifBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifController());
  }

}