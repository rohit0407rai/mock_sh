import 'dart:developer';

import 'database_services.dart';

class UserService {
  static Future<bool> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      // Ensure the DB connection is open
      await DBService.connect();

      // Get the user_data collection
      final collection = DBService.getCollection("user_data");

      // Check if the user already exists
      final existingUser = await collection.findOne({"email": email});
      if (existingUser != null) {
        throw Exception("User with this email already exists");
      }

      // Insert the new user
      await collection.insert({
        "username": username,
        "email": email,
        "password": password, // Ideally, hash the password before storing
      });

      return true;
    } catch (e) {
      log("Error in registration: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Ensure the DB connection is open
      await DBService.connect();

      // Get the user_data collection
      final collection = DBService.getCollection("user_data");

      // Find the user by email
      final user = await collection.findOne({"email": email});

      if (user == null) {
        throw Exception("User not found");
      }

      // Verify the password (ensure password hashing in production)
      if (user["password"] != password) {
        throw Exception("Invalid password");
      }

      // Extract required fields
      return {
        "username": user["username"] ?? "Unknown User",
        "email": user["email"],
      };
    } catch (e) {
      log("Error in login: $e");
      return null;
    }
  }
}
