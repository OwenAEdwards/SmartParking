import 'package:flutter/material.dart';
import 'package:smart_parking/core/theme.dart';
import 'package:smart_parking/routes/app_routes.dart';
import 'package:smart_parking/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const SmartParkingApp(),
    ),
  );
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
