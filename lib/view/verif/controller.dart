import 'package:get/get.dart';
import 'package:spotify/data/auth/service/auth.service.dart';

import '../../data/auth/model/token.dart';
import '../../routes/pages.dart';

class VerifController extends GetxController {
  AuthService service = AuthService();

  @override
  void onInit() {
    super.onInit();
  }


  Rx<Token> tokenModel = Token().obs;
  Future<void> login() async {
    try {
      tokenModel.value = await service.getTokenLogin({
        "grant_type": "client_credentials",
        "client_id": "1ceb7216d87c4d918c19b0bc75153c84",
        "client_secret": "db0c6a348ad84b8d8eb22141f182f1de",
      });
      Get.toNamed(Routes.home);
    } catch (e, stackTrace){
      print("error:  $e");
      print("stackTrace: $stackTrace");
    }
  }
}