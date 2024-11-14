import 'package:get/get.dart';
import 'package:spotify/view/playlist/playlist.controller.dart';

class PlayListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayListController());
  }

}