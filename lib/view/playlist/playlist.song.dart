import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify/data/auth/service/api.constant.dart';
import 'package:spotify/view/home/controller.dart';
import 'package:spotify/view/playlist/playlist.controller.dart';

class PlayList extends GetView<PlayListController> {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    controller.playListSongData();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF343130),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/yovie.jpg',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.artistList.value.name ?? 'No Name',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '${homeController.artistList.value.followers?.total?.toString() ?? '0'} followers',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Overlay untuk judul 'Popular'
            Positioned(
              top: 250, // Sesuaikan posisi dengan gambar
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xFF343130).withOpacity(0.8), // Opacity untuk latar belakang
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Title',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Obx(() => IconButton(
                          onPressed: () {
                           // controller.isSuccess.value = !controller.isSuccess.value;
                            controller.handlePlayPause();
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300), // Transition duration
                            child: controller.isSuccess.value
                                ? Image.asset(
                              'assets/images/play_button.png',
                              key: ValueKey<int>(0), // Unique key for each widget
                            )
                                : Image.asset(
                              'assets/images/pause.png',
                              key: ValueKey<int>(1), // Unique key for each widget
                            ),
                          ),
                        ),),
                        Text(
                          'Album',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ListView yang terletak di bawah, menggunakan Obx untuk memantau perubahan
            Positioned(
              top: 320, // Memberikan jarak di atas agar tidak tumpang tindih
              bottom: 0, // Memungkinkan ListView mengisi sisa ruang
              left: 0,
              right: 0,
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.tracks.length,
                  itemBuilder: (context, index) {
                    final item = controller.tracks[index];
                    return SizedBox(
                      height: 80,
                      child: Card(
                        color: Colors.grey[800], // Memberikan warna latar belakang pada card
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16), // Menambahkan padding agar elemen tidak terlalu menempel di tepi
                          leading: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset('assets/images/yovie.jpg'),
                          ),
                          title: InkWell(
                            onTap: () {
                              controller.openSpotify();
                            },
                            child: Text(
                              item.name ?? '',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            item.artists?.map((e) => e.name).join(', ') ?? '',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          trailing: Text(
                            item.album?.name ?? '',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
