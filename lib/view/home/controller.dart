import 'package:get/get.dart';
import 'package:spotify/data/auth/model/artist.dart';
import 'package:spotify/data/auth/service/auth.service.dart';

import '../../data/auth/model/token.dart';

class HomeController extends GetxController {
  AuthService service = AuthService();

  @override
  void onInit() {
    super.onInit();
    listSongData();
   // login();
  }


  // Rx<Token> tokenModel = Token().obs;
  // Future<void> login() async {
  //   try {
  //     tokenModel.value = await service.getTokenLogin( {
  //       "grant_type": "client_credentials",
  //       "client_id": "1ceb7216d87c4d918c19b0bc75153c84",
  //       "client_secret": "db0c6a348ad84b8d8eb22141f182f1de",
  //     });
  //   } catch (e, stackTrace){
  //     print("error:  $e");
  //     print("stackTrace: $stackTrace");
  //   }
  // }

  Rx<Artist> artistList = Artist().obs;
  Future<void> listSongData() async {
    try {
      artistList.value = await service.artistModel();
      print('name: ${artistList.value.name}');
    } catch (e) {
      print(e);
    }
  }
}