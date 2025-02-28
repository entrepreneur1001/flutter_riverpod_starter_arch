import 'package:flutter/material.dart';

/// `ProviderOptions` is a configuration class that holds options for customizing
/// the behavior and appearance of provider-related widgets.
///
/// This class encapsulates options for both `ProviderBuilder` and `ProviderListener` widgets,
/// allowing developers to set default views and behaviors for loading and error states.
///
/// - [providerBuilderOptions]: Options for customizing `ProviderBuilder` widgets.
/// - [providerListenerOptions]: Options for customizing `ProviderListener` widgets.
class ProviderOptions {
  /// Options for customizing the behavior and appearance of `ProviderBuilder` widgets.
  final ProviderBuilderOptions? providerBuilderOptions;

  /// Options for customizing the behavior and appearance of `ProviderListener` widgets.
  final ProviderListenerOptions? providerListenerOptions;

  /// Constructor for `ProviderOptions`.
  ///
  /// This allows you to pass custom options for both `ProviderBuilder` and `ProviderListener`.
  ///
  /// Example:
  /// ```dart
  /// final options = ProviderOptions(
  ///   providerBuilderOptions: ProviderBuilderOptions(
  ///     loadingView: CircularProgressIndicator(),
  ///     errorView: Text("An error occurred"),
  ///   ),
  ///   providerListenerOptions: ProviderListenerOptions(
  ///     loading: CircularProgressIndicator(),
  ///     onListenerError: (errorMessage) {
  ///       print("Error: $errorMessage");
  ///     },
  ///   ),
  /// );
  /// ```
  const ProviderOptions({
    this.providerBuilderOptions,
    this.providerListenerOptions,
  });
}

/// `ProviderBuilderOptions` is a configuration class used to customize the appearance
/// of `ProviderBuilder` widgets, specifically for handling loading and error states.
///
/// - [loadingView]: A widget to display when data is loading.
/// - [errorView]: A widget to display when an error occurs.
class ProviderBuilderOptions {
  /// A widget to display during the loading state.
  final Widget? loadingView;

  /// A widget to display when an error occurs.
  final Widget? errorView;

  /// Constructor for `ProviderBuilderOptions`.
  ///
  /// This allows you to set custom loading and error views that will be used by `ProviderBuilder` widgets.
  ///
  /// Example:
  /// ```dart
  /// final builderOptions = ProviderBuilderOptions(
  ///   loadingView: CircularProgressIndicator(),
  ///   errorView: Text("An error occurred"),
  /// );
  /// ```
  const ProviderBuilderOptions({
    this.loadingView,
    this.errorView,
  });
}

/// `ProviderListenerOptions` is a configuration class used to customize the behavior
/// and appearance of `ProviderListener` widgets, specifically for handling loading
/// and error events.
///
/// - [loading]: A widget to display when the listener is in a loading state.
/// - [onListenerError]: A callback function that is triggered when an error occurs,
///   providing the error message.
class ProviderListenerOptions {
  /// A widget to display during the loading state.
  final Widget? loading;

  /// A callback function that is triggered when an error occurs.
  ///
  /// This function receives the error message as a string.
  final Function(String errorMessage)? onListenerError;

  /// Constructor for `ProviderListenerOptions`.
  ///
  /// This allows you to set custom loading views and error handling logic for `ProviderListener` widgets.
  ///
  /// Example:
  /// ```dart
  /// final listenerOptions = ProviderListenerOptions(
  ///   loading: CircularProgressIndicator(),
  ///   onListenerError: (errorMessage) {
  ///     print("Error: $errorMessage");
  ///   },
  /// );
  /// ```
  const ProviderListenerOptions({
    this.loading,
    this.onListenerError,
  });
}
