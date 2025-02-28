import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'root_state_notifier.dart';

/// Abstract base class for state notifiers that manage asynchronous states with parameters.
///
/// [BaseStateNotifierWithParam] provides a structure for handling asynchronous
/// operations that require parameters. It extends [RootStateNotifier] to
/// utilize the shared functionality.
abstract class BaseStateNotifierWithParam<T, R>
    extends RootStateNotifier<T, R> {
  BaseStateNotifierWithParam({super.initialState});

  /// Represents the asynchronous operation to fetch or process data with optional parameters.
  ///
  /// This method should be overridden to define the asynchronous operation that uses
  /// the provided [param]. Calling [future] directly may result in unexpected behavior.
  /// Prefer using the [call] method to trigger the asynchronous operation.
  Future<T> future(R param);

  /// Fetches data asynchronously with optional parameters and updates the state accordingly.
  ///
  /// This method triggers the loading state, performs an asynchronous operation
  /// using the [future] method, and then updates the state based on the result.
  /// If the operation succeeds, the state is set to the loaded data;
  /// if it fails, the state is set to an error state.
  ///
  /// Throws a [StateError] if called before setting the [future] method.
  Future<AsyncValue<T>?> call(R param) async {
    if (allowCall) {
      state = const AsyncLoading();

      // Perform the asynchronous operation
      try {
        final T response = await future(param);
        // Handle the response
        onLoadedState(response);
      } catch (e, stackTrace) {
        state = AsyncError(e, stackTrace);
      }
    }
    return state;
  }
}
