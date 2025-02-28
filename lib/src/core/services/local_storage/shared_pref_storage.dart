// Import necessary packages
import 'dart:developer'; // Used for logging exceptions and events.
import 'package:shared_preferences/shared_preferences.dart'; // Provides access to shared preferences.
import '../local_storage/tw_local_storage.dart'; // Custom local storage interface to be implemented by SharedPrefStorage.

/// `SharedPrefStorage` class handles storing, reading, and deleting data
/// using `SharedPreferences`. It extends the generic `TWLocalStorage<Object>` class.
class SharedPrefStorage extends TWLocalStorage<Object> {
  // The instance of SharedPreferences which is initialized asynchronously.
  late final SharedPreferences _prefs;

  /// Constructor to initialize SharedPrefStorage.
  /// It calls the `_init` method to asynchronously initialize `_prefs`.
  SharedPrefStorage() {
    _init();
  }

  /// Asynchronously initializes the `_prefs` instance.
  /// It retrieves the instance of SharedPreferences.
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Deletes a specific key from shared preferences.
  ///
  /// - Parameters:
  ///   - `key`: The key to be removed from shared preferences.
  /// - Exception Handling: If any error occurs during deletion, it logs the error.
  @override
  Future<void> delete(String key) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
    }
  }

  /// Deletes all keys and values from shared preferences.
  ///
  /// - Exception Handling: If an error occurs during clearing, it logs the error.
  @override
  Future<void> deleteAll() async {
    try {
      await _prefs.clear();
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
    }
  }

  /// Reads a value associated with a given key from shared preferences.
  ///
  /// - Parameters:
  ///   - `key`: The key whose value needs to be read.
  /// - Returns: The value if it exists, otherwise `null`.
  /// - Exception Handling: Logs any errors encountered during the read operation.
  @override
  Object? read(String key) {
    try {
      return _prefs.get(key); // get the value dynamically by key.
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
      return null; // Returns null if any error occurs.
    }
  }

  /// Reads a boolean value associated with the given key.
  ///
  /// - Parameters:
  ///   - `key`: The key whose boolean value is to be retrieved.
  /// - Returns: The boolean value if found, otherwise `null`.
  bool? getBool(String key) => _prefs.getBool(key);

  /// Reads a double value associated with the given key.
  ///
  /// - Parameters:
  ///   - `key`: The key whose double value is to be retrieved.
  /// - Returns: The double value if found, otherwise `null`.
  double? getDouble(String key) => _prefs.getDouble(key);

  /// Reads an integer value associated with the given key.
  ///
  /// - Parameters:
  ///   - `key`: The key whose integer value is to be retrieved.
  /// - Returns: The integer value if found, otherwise `null`.
  int? getInt(String key) => _prefs.getInt(key);

  /// Reads a string value associated with the given key.
  ///
  /// - Parameters:
  ///   - `key`: The key whose string value is to be retrieved.
  /// - Returns: The string value if found, otherwise `null`.
  String? getString(String key) => _prefs.getString(key);

  /// Reads a list of strings associated with the given key.
  ///
  /// - Parameters:
  ///   - `key`: The key whose string list is to be retrieved.
  /// - Returns: The list of strings if found, otherwise `null`.
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  /// Reads all key-value pairs from shared preferences.
  ///
  /// - Returns: A map containing all keys and their associated values if found,
  ///   otherwise `null`.
  /// - Exception Handling: Logs any errors encountered during the read operation.
  @override
  Map<String, Object>? readAllValues() {
    try {
      final Set<String> keys = _prefs.getKeys(); // Get all keys.
      Map<String, Object>? values =
          {}; // Initialize an empty map for storing key-value pairs.

      // Iterate through each key and retrieve its value.
      for (String key in keys) {
        final value = _prefs.get(key); // Dynamically fetch value by key.
        if (value != null) {
          values[key] =
              value; // Add the key-value pair to the map if the value is not null.
        }
      }
      return values; // Return the map containing all key-value pairs.
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
      return null; // Return null if any error occurs.
    }
  }

  /// Writes a value associated with a given key to shared preferences.
  ///
  /// - Parameters:
  ///   - `key`: The key to associate with the value.
  ///   - `value`: The value to be stored, which can be of types: `int`, `double`, `bool`, `String`, or `List<String>`.
  /// - Exception Handling: Logs any errors encountered during the write operation.
  /// - Throws: Exception if the provided value type is unsupported.
  @override
  Future<void> write(String key, Object value) async {
    try {
      // Depending on the type of the value, store it using the appropriate method.
      if (value is int) {
        await _prefs.setInt(key, value);
      } else if (value is double) {
        await _prefs.setDouble(key, value);
      } else if (value is bool) {
        await _prefs.setBool(key, value);
      } else if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is List<String>) {
        await _prefs.setStringList(key, value);
      } else {
        // Throw an exception if the value is of an unsupported type.
        throw Exception(
          'allowed data types: int, double, bool, string and List<String>',
        );
      }
    } catch (e) {
      log(e.toString()); // Logs the exception message if an error occurs.
    }
  }
}
