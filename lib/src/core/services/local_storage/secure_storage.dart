// Import necessary packages
import 'dart:developer'; // Used for logging exceptions and events.
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Provides access to secure storage for sensitive data.
import '../local_storage/tw_local_storage.dart'; // Custom local storage interface to be implemented by SecureStorage.

/// `SecureStorage` class handles secure storage of sensitive data using `FlutterSecureStorage`.
/// It extends the generic `TWLocalStorage<String>` class, allowing for secure read, write, and delete operations.
class SecureStorage extends TWLocalStorage<String> {
  // The instance of FlutterSecureStorage, used to store sensitive information securely.
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Deletes a specific key from secure storage.
  ///
  /// - Parameters:
  ///   - `key`: The key to be removed from secure storage.
  /// - Exception Handling: Logs any error encountered during the deletion process.
  @override
  Future<void> delete(String key) async {
    try {
      await _storage.delete(
        key: key,
      ); // Removes the value associated with the key.
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
    }
  }

  /// Deletes all keys and values from secure storage.
  ///
  /// - Exception Handling: Logs any error encountered during the clear operation.
  @override
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll(); // Deletes all stored data in secure storage.
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
    }
  }

  /// Reads a value associated with the given key from secure storage.
  ///
  /// - Parameters:
  ///   - `key`: The key whose value needs to be read.
  /// - Returns: The value if it exists, otherwise `null`.
  /// - Exception Handling: Logs any errors encountered during the read operation.
  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(
        key: key,
      ); // Retrieves the value associated with the key.
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
      return null; // Returns null if any error occurs.
    }
  }

  /// Reads all key-value pairs stored in secure storage.
  ///
  /// - Returns: A `Map` containing all the keys and their associated values.
  /// - Exception Handling: Logs any errors encountered during the read operation.
  @override
  Future<Map<String, String>?> readAllValues() async {
    try {
      return await _storage
          .readAll(); // Retrieves all key-value pairs stored in secure storage.
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
      return null; // Returns null if any error occurs.
    }
  }

  /// Writes a key-value pair to secure storage.
  ///
  /// - Parameters:
  ///   - `key`: The key to associate with the value.
  ///   - `value`: The value to be stored (must be of type `String`).
  /// - Exception Handling: Logs any errors encountered during the write operation.
  @override
  Future<void> write(String key, String value) async {
    try {
      await _storage.write(
        key: key,
        value: value,
      ); // Writes the key-value pair to secure storage.
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
    }
  }
}
