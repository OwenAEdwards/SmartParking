import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_parking/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService _apiService = ApiService();  // Instantiate ApiService

  // Sign in with Google (Firebase)
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        debugPrint("Google authentication failed: User canceled sign-in.");
        return false;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Check if the ID token and access token are null
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        debugPrint("Google authentication failed: No ID token or access token available.");
        return false;  // Handle the case where the ID token is missing.
      }

      final String idToken = googleAuth.idToken!;
      final String accessToken = googleAuth.accessToken!;

      // Firebase authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      // If the user is null, sign-in failed
      if (user == null) {
        debugPrint("Firebase sign-in failed: User is null.");
        return false;
      }

      // Call the backend to exchange the ID token for a JWT token
      final bool success = await _apiService.loginWithGoogle(idToken);
      if (success) {
        final String? jwtToken = await _apiService.getJWTToken();
        if (jwtToken != null) {
          await _storage.write(key: 'jwt_token', value: jwtToken);
          _isAuthenticated = true;
          notifyListeners();
          return true;
        } else {
          debugPrint("Failed to retrieve JWT token from backend.");
        }
      } else {
        debugPrint("Backend login with Google failed.");
      }
    } catch (e, stackTrace) {
      debugPrint("Google sign-in error: $e");
      debugPrint("Stack Trace: $stackTrace");
    }
    return false;
  }

  // Sign out from Firebase
  Future<void> logout() async {
    try {
      await _auth.signOut(); // Firebase sign-out
      await _storage.delete(key: 'jwt_token'); // Clear stored JWT token
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Error during sign-out: $e");
    }
  }

  // Check if the user is authenticated
  Future<bool> checkAuthentication() async {
    try {
      final user = _auth.currentUser;
      return user != null;
    } catch (e) {
      debugPrint("Error checking authentication: $e");
      return false;
    }
  }

  Future<bool> signInWithMicrosoft() async {
    // Microsoft OAuth is more complex in Flutter, usually requiring a WebView or an external library.
    // You'd typically use `msal_flutter` or open an auth browser for login.
    // Implement a similar logic as Google, sending the ID token to your backend.
    return false;
  }
}
