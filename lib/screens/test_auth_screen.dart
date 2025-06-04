// lib/screens/test_auth_screen.dart
import 'package:flutter/material.dart';
import 'package:menejemen_reservasi/services/appwrite_service.dart';
import 'package:appwrite/appwrite.dart';

class TestAuthScreen extends StatefulWidget {
  const TestAuthScreen({super.key});

  @override
  State<TestAuthScreen> createState() => _TestAuthScreenState();
}

class _TestAuthScreenState extends State<TestAuthScreen> {
  final AppwriteService appwrite = AppwriteService();

  String output = '';

  Future<void> _login() async {
    try {
      final session = await appwrite.account.createEmailSession(
        email: 'tes@email.com', // Ganti sesuai akunmu
        password: 'password123',
      );
      setState(() {
        output = 'Login berhasil:\n${session.toMap()}';
      });
    } catch (e) {
      setState(() {
        output = 'Login gagal: $e';
      });
    }
  }

  Future<void> _signup() async {
    try {
      final user = await appwrite.account.create(
        userId: ID.unique(),
        email: 'tes@email.com',
        password: 'password123',
        name: 'Tester Satu',
      );
      setState(() {
        output = 'Signup berhasil:\n${user.toMap()}';
      });
    } catch (e) {
      setState(() {
        output = 'Signup gagal: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Auth')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(onPressed: _signup, child: const Text('Sign Up')),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            const SizedBox(height: 20),
            Text(output),
          ],
        ),
      ),
    );
  }
}
