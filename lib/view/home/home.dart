import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify/view/home/controller.dart';
import 'package:spotify/view/playlist/playlist.controller.dart';

import '../../data/auth/service/api.constant.dart';
import '../../routes/pages.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  // Widget shimmerLoading() {
  //   return Shimmer.fromColors(
  //       child: GridView.builder(
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2, // Jumlah kolom sementara
  //       crossAxisSpacing: 1.0,
  //       mainAxisSpacing: 1.0,
  //       childAspectRatio: 0.5, // Rasio aspek untuk item
  //     ),
  //         itemCount: controller.artistList.length, // Jumlah item shimmer
  //     itemBuilder: (context, index) {
  //       return Container(
  //         margin: const EdgeInsets.all(3.0),
  //         decoration: BoxDecoration(
  //           color: Colors.grey,
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //       );
  //     },
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    PlayListController playListController = Get.put(PlayListController());

    controller.listSongData();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color(0xFF343130),
          child: Obx(() {
            if (controller.artistList.value.name == null ||
                controller.artistList.value.name!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Top Result', style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: 300,
                      height: 200,
                      color: const Color(0xFF4f4846),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset('assets/images/edoh.jpg',
                                  fit: BoxFit.cover,),
                                ),
                            ),
                            const SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.playlist);
                                    },
                                  child: Text(controller.artistList.value.name ?? 'No Name', style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Text(controller.artistList.value.type ?? 'No Type', style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
