import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';
class DBService {
  static Db? _db;
  static const String connectionString =
      "mongodb+srv://rohit0407:Chakra321@cluster0.m7stjp0.mongodb.net/myapp_users?retryWrites=true&w=majority";

  // Connect to the database
  static Future<void> connect() async {
    if (_db == null) {
      _db = await Db.create(connectionString);
      await _db!.open();
      log("Connected to MongoDB");
    }
  }

  // Get the collection
  static DbCollection getCollection(String collectionName) {
    if (_db == null) {
      throw Exception("Database not connected");
    }
    return _db!.collection(collectionName);
  }

  // Disconnect the database (optional)
  static Future<void> disconnect() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
      log("Disconnected from MongoDB");
    }
  }
}
