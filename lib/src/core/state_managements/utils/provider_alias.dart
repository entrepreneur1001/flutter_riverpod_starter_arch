import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_managements.dart';

/// Type alias for a [StateNotifierProvider] that manages an asynchronous state of type [AsyncValue<T>?].
///
/// This alias is used to create a [StateNotifierProvider] for notifiers that do not require
/// additional parameters for data fetching or processing.
typedef BaseStateNotifierType<T>
    = StateNotifierProvider<BaseStateNotifier<T>, AsyncValue<T>?>;

/// Type alias for an [AutoDisposeStateNotifierProvider] that manages an asynchronous state of type [AsyncValue<T>?].
///
/// This alias is used to create a provider that automatically disposes when no longer needed,
/// and is for state notifiers that do not require additional parameters.
typedef BaseStateNotifierAutoDisposeType<T>
    = AutoDisposeStateNotifierProvider<BaseStateNotifier<T>, AsyncValue<T>?>;

/// Type alias for a [StateNotifierProvider] that manages an asynchronous state of type [AsyncValue<T>?]
/// and supports fetching data with optional parameters of type [R].
///
/// This alias is used to create a [StateNotifierProvider] for notifiers that require parameters
/// for data fetching or processing.
typedef BaseStateNotifierWithParamsType<T, R>
    = StateNotifierProvider<BaseStateNotifierWithParam<T, R>, AsyncValue<T>?>;

/// Type alias for an [AutoDisposeStateNotifierProvider] that manages an asynchronous state of type [AsyncValue<T>?]
/// and supports fetching data with optional parameters of type [R].
///
/// This alias is used to create a provider that automatically disposes when no longer needed,
/// and is for state notifiers that require parameters for data fetching or processing.
typedef BaseStateNotifierAutoDisposeWithParamsType<T, R>
    = AutoDisposeStateNotifierProvider<BaseStateNotifierWithParam<T, R>,
        AsyncValue<T>?>;
