import 'package:get/get.dart';
import 'package:spotify/view/home/home.binding.dart';
import 'package:spotify/view/playlist/playlist.binding.dart';
import 'package:spotify/view/playlist/playlist.song.dart';
import 'package:spotify/view/splash/splash_screen.dart';
import 'package:spotify/view/verif/verif.binding.dart';

import '../view/home/home.dart';
import '../view/verif/verif.dart';

part 'routes.dart';

List<GetPage> pages = [
  GetPage(name: Routes.inital, page:() => const SplashScreen()),
  GetPage(name: Routes.home, page:() => const HomePage(), binding: HomeBinding()),
  GetPage(name: Routes.verif, page:() => const Verif(), binding: VerifBinding()),
  GetPage(name: Routes.playlist, page:() => const PlayList(), binding: PlayListBinding(), transition: Transition.fadeIn),
];