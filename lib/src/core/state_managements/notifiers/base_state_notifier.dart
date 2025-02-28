import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'root_state_notifier.dart';

/// Abstract base class for state notifiers that manage asynchronous states.
///
/// [BaseStateNotifier] provides a structure for handling asynchronous
/// operations without parameters. It extends [RootStateNotifier] to
/// utilize the shared functionality.
abstract class BaseStateNotifier<T> extends RootStateNotifier<T, void> {
  BaseStateNotifier({super.initialState});

  /// Represents the asynchronous operation to fetch or process data.
  ///
  /// This property should be set before calling the [call] function. Calling [future]
  /// directly may result in unexpected behavior. Prefer using the [call] method
  /// to trigger the asynchronous operation.
  Future<T> get future;

  /// Fetches data asynchronously and updates the state accordingly.
  ///
  /// This method triggers the loading state, performs an asynchronous operation
  /// using the [future], and then updates the state based on the result.
  /// If the operation succeeds, the state is set to the loaded data;
  /// if it fails, the state is set to an error state.
  ///
  /// Throws a [StateError] if called before setting the [future] property.
  Future<AsyncValue<T>?> call() async {
    if (allowCall) {
      state = const AsyncLoading();

      // Perform the asynchronous operation
      try {
        final T response = await future;
        // Handle the response
        onLoadedState(response);
      } catch (e, stackTrace) {
        state = AsyncError(e, stackTrace);
      }
    }
    return state;
  }
}
