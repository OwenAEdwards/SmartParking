import 'package:flutter/material.dart';
import 'package:smart_parking/views/home_screen.dart';
import 'package:smart_parking/views/parking_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomeScreen(),
    '/parking': (context) => const ParkingScreen(),
  };
}
