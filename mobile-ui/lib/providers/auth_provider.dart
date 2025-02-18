import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance

  // Sign in with Google (Firebase)
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Check if the ID token is null before accessing it
      if (googleAuth.idToken == null) {
        debugPrint("Google authentication failed, no ID token available.");
        return false;  // Handle the case where the ID token is missing.
      }

      final String idToken = googleAuth.idToken!;

      // Firebase sign-in with Google
      final AuthCredential credential = GoogleAuthProvider.credential(idToken: idToken);
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        // Store the authentication token in secure storage
        final token = await user.getIdToken();
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

  // Sign out from Firebase
  Future<void> logout() async {
    await _auth.signOut(); // Firebase sign-out
    await _storage.delete(key: 'auth_token');
    _isAuthenticated = false;
    notifyListeners();
  }

  // Check if the user is authenticated
  Future<bool> checkAuthentication() async {
    final user = _auth.currentUser;
    return user != null;
  }

  Future<bool> signInWithMicrosoft() async {
    // Microsoft OAuth is more complex in Flutter, usually requiring a WebView or an external library.
    // You'd typically use `msal_flutter` or open an auth browser for login.
    // Implement a similar logic as Google, sending the ID token to your backend.
    return false;
  }
}
