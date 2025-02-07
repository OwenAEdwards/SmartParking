import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  // Function to log the user in
  Future<void> login(String username, String password) async {
    // Call an API or some logic to verify credentials
    _isAuthenticated = true; // Assume successful login
    notifyListeners();
  }

  // Function to log the user out
  Future<void> logout() async {
    _isAuthenticated = false;
    notifyListeners();
  }
}
