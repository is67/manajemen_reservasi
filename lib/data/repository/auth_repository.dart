import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart'; // Import models for Session and User
import '../../config/appwrite_config.dart';

class AuthRepository {
  final Account _account = AppwriteConfig.account;

  // Login with email and password
  Future<Session> login(String email, String password) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return session;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Register new user
  Future<User> register(String email, String password, String name) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    try {
      final user = await _account.get();
      return user;
    } catch (e) {
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
