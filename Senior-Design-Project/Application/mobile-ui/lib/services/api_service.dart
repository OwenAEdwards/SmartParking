import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8080/api"; // TODO: Replace with Azure link on deploy
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Login function to exchange Google ID token for JWT
  Future<bool> loginWithGoogle(String idToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/google'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idToken": idToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final jwtToken = data['token'];
      if (jwtToken != null) {
        // Store the JWT token in secure storage
        await storage.write(key: 'jwt_token', value: jwtToken);
        return true;
      }
    }
    return false;
  }

  // Get JWT token function (already stored in secure storage)
  Future<String?> getJWTToken() async {
    return await storage.read(key: 'jwt_token');
  }

  // Logout function
  Future<void> logout() async {
    await storage.delete(key: 'jwt_token');
  }

  // Check if the user is authenticated by checking for JWT
  Future<bool> isAuthenticated() async {
    String? token = await storage.read(key: 'jwt_token');
    return token != null;
  }
}
