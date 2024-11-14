import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/auth/utils/storage.dart';
import '../../routes/pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  final Storage storage = Storage();
  final GetStorage box = GetStorage();
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });

    controller.forward().whenComplete(() async {
      final token = storage.getToken();
      final exp = storage.getExp();
      if (token != null && exp != null) {
        final currentTime = DateTime.now();
        if (exp.isAfter(currentTime)) {
          Get.offAllNamed(Routes.home);
        } else {
          print('expired');
          Get.toNamed(Routes.verif);
        }
      } else {
        Get.toNamed(Routes.verif);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFF343130),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                      'assets/images/spot.png'), // Ganti dengan logo Anda
                ),
                const SizedBox(width: 5),
                const Text('|', style: TextStyle(fontSize: 15)),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
