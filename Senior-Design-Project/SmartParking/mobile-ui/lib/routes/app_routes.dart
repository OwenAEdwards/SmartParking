import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/views/parking_screen.dart';
import 'package:smart_parking/views/login_screen.dart';
import 'package:smart_parking/views/settings_screen.dart';
import 'package:smart_parking/providers/auth_provider.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) {
      var isAuthenticated =
          Provider.of<AuthProvider>(context, listen: false).isAuthenticated;
      return isAuthenticated ? const ParkingScreen() : const LoginScreen();
    },
    '/parking': (context) => const ParkingScreen(),
    '/login': (context) => const LoginScreen(),
    '/settings': (context) => const SettingsScreen(),
  };
}
