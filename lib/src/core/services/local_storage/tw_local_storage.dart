import 'dart:async';

abstract class TWLocalStorage<T extends Object?> {
  /// Read value
  FutureOr<Object?> read(String key);

  /// Read all values
  FutureOr<Map<String, Object>?> readAllValues();

  /// Delete value
  FutureOr<void> delete(String key);

  /// Delete all
  FutureOr<void> deleteAll();

  /// Write value
  FutureOr<void> write(
    String key,
    T value,
  );
}
