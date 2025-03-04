import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign in with:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  bool success = await authProvider.signInWithGoogle();
                  if (success) {
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Google login failed')),
                    );
                  }
                },
                child: const Text('Sign in with Google'),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  bool success = await authProvider.signInWithMicrosoft();
                  if (success) {
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Microsoft login failed')),
                    );
                  }
                },
                child: const Text('Sign in with Microsoft'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
