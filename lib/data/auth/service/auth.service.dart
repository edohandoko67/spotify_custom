import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spotify/data/auth/model/artist.dart';
import 'package:spotify/data/auth/model/track.dart';
import 'package:spotify/data/auth/service/api.constant.dart';
import '../model/token.dart';
import '../provider/api.provider.dart';
import '../utils/storage.dart';
import 'package:dio/dio.dart' as dio;

class AuthService {
  HttpClient httpClient = HttpClient(baseUrl: ApiConstant.baseUrl);
  HttpClient httpClient2 = HttpClient(baseUrl: ApiConstant.baseUrl2);
  HttpClient httpClient3 = HttpClient(baseUrl: ApiConstant.baseUrlSong);
  final Storage _storage = Storage();

  Future<Token> getTokenLogin(Map<String, dynamic> data) async {
    try {
      dio.Response response = await httpClient.post(ApiConstant.accessToken, data: data);
      final body = response.data;
      if (body != null) {
        String accessToken = body['access_token'];
        _storage.saveToken(accessToken);
        int exp = body['expires_in'];
        _storage.saveExpired(exp); // Menyimpan waktu kedaluwarsa dalam storage
        print('exp: $exp');
        return Token.fromJson(body);
      } else {
        throw Exception('Failed to retrieve access token');
      }
    } on dio.DioError catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal terhubung ke Server. Coba lagi!');
      throw Exception(_.message);
    }
  }

  Future<Artist> artistModel() async {
    try {
      dio.Response response = await httpClient2.get(ApiConstant.listSong);
      final body = response.data;
      if (body != null) {
        //List<Artist> artists = body.map((data) => Artist.fromJson(data)).toList();
        return Artist.fromJson(body);
      } else {
        throw Exception('Failed to retrieve artists data');
      }
    } on dio.DioError catch(_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal terhubung ke Server. Coba lagi!');
      throw Exception(_.message);
    }
  }

  Future<List<Artist>> playListSong() async {
    try {
      dio.Response response = await httpClient2.get(ApiConstant.listSong);
      final body = response.data;
      if (body != null) {
        List<Artist> artists = body.map((data) => Artist.fromJson(data)).toList();
        return artists;
      } else {
        throw Exception('Failed to retrieve artists data');
      }
    } on dio.DioError catch(_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal terhubung ke Server. Coba lagi!');
      throw Exception(_.message);
    }
  }

  Future<List<Track>> listTrack({int offset = 0, required int limit}) async {
    try {
      dio.Response response = await httpClient3.get(
        ApiConstant.tanpaCinta,
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );

      final body = response.data['items'];
      print('Isi response data: $body');

      if (body != null && body is List) {
        // Memetakan setiap item dalam 'items' menjadi objek Track
        List<Track> trackList = body.map<Track>((data) {
          // Pemetaan data ke objek Track
          return Track.fromJson(data); // Pastikan data sesuai dengan format yang diinginkan
        }).toList();
        return trackList;
      } else {
        throw Exception('Failed to retrieve song data');
      }
    } on dio.DioError catch (e) {
      EasyLoading.dismiss();
      if (e.type == DioErrorType.connectTimeout) {
        EasyLoading.showError('Timeout, gagal terhubung ke server.');
      } else if (e.type == DioErrorType.receiveTimeout) {
        EasyLoading.showError('Timeout saat menerima data.');
      } else if (e.type == DioErrorType.response) {
        EasyLoading.showError('Server memberikan respons yang salah: ${e.response?.statusCode}');
      } else {
        EasyLoading.showError('Terjadi kesalahan: ${e.message}');
      }
      throw Exception('Error: ${e.message}');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Terjadi kesalahan tidak terduga: $e');
      throw Exception('Error: $e');
    }
  }



}