import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:5000/api"; // TODO: Replace with Azure link on deploy
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Login function
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'jwt_token', value: data['token']);
      return true;
    } else {
      return false;
    }
  }

  // Logout function
  Future<void> logout() async {
    await storage.delete(key: 'jwt_token');
  }

  // Check if the user is authenticated
  Future<bool> isAuthenticated() async {
    String? token = await storage.read(key: 'jwt_token');
    return token != null;
  }
}
