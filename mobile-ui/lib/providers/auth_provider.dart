import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String idToken = googleAuth.idToken!;

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/google'), // TODO: Replace with Azure link on deploy
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['token'];
        await _storage.write(key: 'auth_token', value: token);
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint("Google sign-in error: $e");
    }
    return false;
  }

  Future<bool> signInWithMicrosoft() async {
    // Microsoft OAuth is more complex in Flutter, usually requiring a WebView or an external library.
    // You'd typically use `msal_flutter` or open an auth browser for login.
    // Implement a similar logic as Google, sending the ID token to your backend.
    return false;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    _isAuthenticated = false;
    notifyListeners();
  }
}
