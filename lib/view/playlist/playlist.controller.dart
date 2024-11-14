import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spotify/data/auth/model/artist.dart';
import 'package:spotify/data/auth/service/auth.service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/auth/model/track.dart';

class PlayListController extends GetxController {
  AuthService service = AuthService();
  RxBool isSuccess = true.obs;
  var isOpening = false.obs; // Menyimpan status apakah URL sedang dibuka
  //RxString spotifyUrl = 'https://open.spotify.com/track/5It44CCAJpMBShYw1swvql'.obs;  // URL Spotify yang diterima
  // Declare an RxString to store the Spotify URL
  RxString spotifyUrl = RxString('');



  @override
  void onInit() {
    super.onInit();
    listSongData();
    playListSongData();

  }


  RxList<Artist> artistList = <Artist>[].obs;
  Future<void> listSongData() async {
    try {
      artistList.value = await service.playListSong();
    } catch (e) {
      print(e);
    }
  }

  RxList<Track> tracks = <Track>[].obs;
  Future<void> playListSongData() async {
    try {
      tracks.value = await service.listTrack(limit: 7);
    } catch (e) {
      print(e);
    }
  }

  // Function to open Spotify with the URL
  Future<void> openSpotify() async {
    try {
      isOpening(true); // Mark the app as opening Spotify

      // Safely access the 'spotify' URL
      String url = tracks.first.external_urls?.spotify ?? '';
      if (url.isEmpty) {
        throw 'Spotify URL is empty or not available';
      }

      final Uri spotifyUri = Uri.parse(url); // Convert the URL to a Uri
      print('Trying to open: $spotifyUri');  // Log URL that will be opened

      // Check if the URL can be launched
      if (await canLaunchUrl(spotifyUri)) {
        await launchUrl(spotifyUri);  // Launch the URL
      } else {
        throw 'Could not open the URL: $url'; // Error handling if URL can't be launched
      }
    } catch (e) {
      print("Error opening Spotify: $e"); // Print the error for debugging
    } finally {
      isOpening(false); // Reset the status after opening
    }
  }

  // Function to update Spotify URL reactively
  void setSpotifyUrl(String url) {
    spotifyUrl.value = url;  // Update the RxString with the new URL
  }

}