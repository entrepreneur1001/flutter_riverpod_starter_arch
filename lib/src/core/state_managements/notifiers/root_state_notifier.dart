import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Common abstract base class for state notifiers that manage asynchronous states.
///
/// [RootStateNotifier] provides shared functionality for handling asynchronous
/// operations like data fetching or processing. It extends [StateNotifier] and
/// manages an [AsyncValue<T>?] state, which represents different states of
/// asynchronous data, including loading, success, and error states.
abstract class RootStateNotifier<T, R> extends StateNotifier<AsyncValue<T>?> {
  /// Constructor for [RootStateNotifier].
  ///
  /// Accepts an optional initial state of type [AsyncValue<T>]. If no initial state
  /// is provided, the state is set to null.
  RootStateNotifier({AsyncValue<T>? initialState}) : super(initialState);

  /// Internal flag indicating whether the [call] function is allowed to execute.
  final bool _allowCall = true;

  /// Deprecated: Use [allowCall] instead. This property will be removed in future versions.
  @Deprecated(
    'Use [allowCall] instead. This property will be removed in future versions.',
  )
  bool get allowFetch => _allowCall;

  /// Indicates whether the [call] function is allowed to execute.
  ///
  /// Returns `true` if the [call] function can be invoked; otherwise, returns `false`.
  bool get allowCall => _allowCall;

  /// Handles the state update when data is successfully loaded.
  ///
  /// This function is typically called after a successful response is received
  /// from the asynchronous operation to update the state with the loaded data.
  void onLoadedState(T data) {
    _setLoadedState(data);
  }

  /// Sets the state to a loaded state with the provided data.
  ///
  /// This function is called when the data is successfully loaded
  /// from the asynchronous operation.
  void _setLoadedState(T data) {
    state = AsyncData(data);
  }
}
