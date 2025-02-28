import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExtension<T> on AsyncValue<T>? {
  /// A getter that returns `true` if the current state is considered an initial state.
  ///
  /// This getter checks whether the instance is null, indicating that it is in an
  /// initial or uninitialized state.
  ///
  /// Returns `true` if the state is null; otherwise, returns `false`.
  ///
  /// Example usage:
  /// ```dart
  /// final bool isInitial = myAsyncValue.isInitialState;
  /// ```
  bool get isInitialState => this == null;

  /// A getter that returns `true` if the current state represents an empty state.
  ///
  /// This getter checks whether the instance is not null, does not have an error,
  /// and contains a value that is a List and is empty.
  ///
  /// Returns `true` if the state is not null, does not have an error, has a value and the value,
  /// if a List, is empty; otherwise, returns `false`.
  ///
  /// Example usage:
  /// ```dart
  /// final bool isEmpty = myAsyncValue.isEmptyState;
  /// ```
  bool get isEmptyState {
    return this != null &&
        !this!.hasError &&
        (this?.hasValue ?? false) &&
        this!.value is List &&
        (this!.value as List).isEmpty;
  }

  /// A getter that returns `true` if the state is considered loaded, indicating
  /// that it is not empty and has a value.
  ///
  /// This getter assumes the existence of a method or property named `isEmptyState`
  /// to check whether the state is empty.
  ///
  /// Example usage:
  /// ```dart
  /// final bool loaded = myAsyncValue.isLoadedState;
  /// ```
  bool get isLoadedState => !isEmptyState && (this?.hasValue ?? false);

  /// A getter that returns `true` if the current state represents a loading state.
  ///
  /// This getter checks whether the instance is not null and if its `isLoading`
  /// property is `true`. The `isLoading` property is assumed to be present on the
  /// object to determine the loading state.
  ///
  /// Returns `true` if the state is not null and is in a loading state; otherwise,
  /// returns `false`.
  ///
  /// Example usage:
  /// ```dart
  /// final bool loading = myAsyncValue.isLoadingState;
  /// ```
  bool get isLoadingState => this != null && this!.isLoading;

  /// A getter that returns `true` if the current state represents an error state.
  ///
  /// This getter checks whether the instance is not null and if its `isError`
  /// property is `true`. The `isError` property is assumed to be present on the
  /// object to determine the error state.
  ///
  /// Returns `true` if the state is not null and is in an error state; otherwise,
  /// returns `false`.
  ///
  /// Example usage:
  /// ```dart
  /// final bool error = myAsyncValue.isErrorState;
  /// ```
  bool get isErrorState => this != null && this!.hasError;
}
