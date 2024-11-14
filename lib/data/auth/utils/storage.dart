import 'package:get_storage/get_storage.dart';

class Storage {
  final GetStorage _storage = GetStorage();

  void saveToken(String token) => _storage.write('access_token', token);
  void saveExpired(int exp) => _storage.write('expires_in', exp);

  String? getToken() => _storage.read<String>('access_token');
  // Ambil expires_in sebagai int, lalu konversi ke DateTime
  DateTime? getExp() {
    final exp = _storage.read<int>('expires_in');
    return exp != null ? DateTime.fromMillisecondsSinceEpoch(exp * 1000) : null;  // Konversi dari detik ke milidetik
  }
}