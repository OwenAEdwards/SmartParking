import 'package:flutter/material.dart';
import 'package:smart_parking/views/home_screen.dart';
import 'package:smart_parking/core/theme.dart';
import 'package:smart_parking/routes/app_routes.dart';

void main() {
  runApp(const SmartParkingApp());
}

class SmartParkingApp extends StatelessWidget {
  const SmartParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Parking System',
      theme: AppTheme.lightTheme, // Use custom theme from core/theme.dart
      initialRoute: '/',
      routes: AppRoutes.routes, // Define navigation routes
    );
  }
}
