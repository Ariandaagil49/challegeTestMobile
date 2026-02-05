import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../config/api_config.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<void> addUser(UserModel user);
  Future<void> updateUser(String id, UserModel user);
  Future<void> deleteUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'X-API-PEGAWAI': ApiConfig.apiKey,
  };

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConfig.pegawaiUrl),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        final List<dynamic> jsonList = (decoded['data'] as List<dynamic>);
        return jsonList.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load users: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error getting users: $e');
    }
  }

  @override
  Future<void> addUser(UserModel user) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConfig.pegawaiUrl),
        headers: _headers,
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) return;

      throw Exception(
        'Failed to add user: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  @override
  Future<void> updateUser(String id, UserModel user) async {
    try {
      final url = '${ApiConfig.pegawaiUrl}/$id';
      final response = await client.put(
        Uri.parse(url),
        headers: _headers,
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 200) return;

      throw Exception(
        'Failed to update user: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      final url = '${ApiConfig.pegawaiUrl}/$id';
      final response = await client.delete(Uri.parse(url), headers: _headers);

      if (response.statusCode == 200) return;

      throw Exception(
        'Failed to delete user: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}
