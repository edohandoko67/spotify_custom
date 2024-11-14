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
  RxBool isSuccess = false.obs;
  var isOpening = false.obs; // Menyimpan status apakah URL sedang dibuka
  //RxString spotifyUrl = 'https://open.spotify.com/track/5It44CCAJpMBShYw1swvql'.obs;  // URL Spotify yang diterima
  // Declare an RxString to store the Spotify URL
  RxString spotifyUrl = RxString('');
  final player = AudioPlayer();
  Rx<Duration> currentPosition = Duration.zero.obs;  // Reactive variable to track the current position


  @override
  void onInit() {
    super.onInit();
    listSongData();  // Presumably loads song data, ensure it's implemented
    playListSongData();  // Presumably loads playlist data, ensure it's implemented

    // Set initial audio URL for playback
    _setInitialAudioUrl();

    // Listen to the position stream of the audio player and update currentPosition
    player.positionStream.listen((event) {
      currentPosition.value = event;  // Update the reactive variable
    });
  }

// Set the initial URL for playback (replace with your dynamic URL)
  Future<void> _setInitialAudioUrl() async {
    try {
      // Example direct MP3 URL, replace with valid URL
      await player.setUrl('https://p.scdn.co/mp3-preview/2f37da1d4221f40b9d1a98cd191f4d6f1646ad17');
      player.play();  // Automatically play the audio after loading
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

// Play an audio file (called when user clicks play for another track)
  Future<void> playAudio(String url) async {
    try {
      await player.setUrl(url);  // Set the audio URL dynamically
      player.play();  // Start playing the audio
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

// Handle play/pause functionality
  void handlePlayPause() {
    if (player.playing) {
      player.pause();  // Pause the player
    } else {
      player.play();  // Play the player
    }
    isSuccess.value = !isSuccess.value;  // Toggle the play/pause state
  }

// Seek the audio to a specific position
  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

// Format duration into MM:SS format
  String formattedDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

// Dispose of the player when the controller is closed
  @override
  void onClose() {
    player.dispose();
    super.onClose();
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