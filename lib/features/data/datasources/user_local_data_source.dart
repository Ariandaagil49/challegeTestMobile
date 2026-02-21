import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  static const _key = 'users_cache_v1';

  Future<List<Map<String, dynamic>>> loadRawUsers() async {
    final sp = await SharedPreferences.getInstance();
    final jsonStr = sp.getString(_key);
    if (jsonStr == null || jsonStr.isEmpty) return [];

    final decoded = json.decode(jsonStr);
    if (decoded is List) return decoded.cast<Map<String, dynamic>>();
    return [];
  }

  Future<void> saveRawUsers(List<Map<String, dynamic>> raw) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_key, json.encode(raw));
  }
}
