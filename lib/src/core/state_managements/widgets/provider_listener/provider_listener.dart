import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_riverpod/src/core/state_managements/state_managment_core.dart';

/// `ProviderListener` is a Flutter `StatelessWidget` that listens to a provider
/// and triggers a rebuild or executes callbacks when the provider's state changes.
/// It is designed to simplify the process of reacting to changes in a Riverpod provider.
///
/// This widget is useful for handling loading states, successful data retrieval,
/// and error states in a consistent manner across your application.
///
/// [T] is the type of the data the provider emits.
class ProviderListener<T> extends StatelessWidget {
  /// The builder function that is called when the provider's state changes.
  /// It provides the `BuildContext` and the `WidgetRef`.
  final Widget Function(BuildContext context, WidgetRef ref) builder;

  /// The provider to listen to for changes.
  final ProviderListenable provider;

  /// Callback function that is called on successful data retrieval.
  /// It provides the `BuildContext`, the retrieved data of type [T], and the `WidgetRef`.
  final void Function(BuildContext context, T data, WidgetRef ref)? onSuccess;

  /// Callback function that is called in case of an error.
  /// It provides the `BuildContext`, the `WidgetRef`, and the `TWFailure` representing the error.
  final void Function(BuildContext context, WidgetRef ref)? onError;

  /// Flag to determine whether to display a loading indicator during data fetching.
  final bool showLoading;

  /// Flag to determine whether to block the screen while loading.
  /// If set to `true`, the screen will be blocked with a loading indicator.
  final bool blockScreenWhileLoading;

  /// Flag to determine whether to display error messages.
  final bool showErrorMessage;

  /// Custom error message to be displayed in case of an error.
  /// If not provided, the default error message from the `AsyncError` state will be used.
  final String? errorMessage;

  /// Constructor for the `ProviderListener` widget.
  ///
  /// [builder] is required and is the function that builds the widget when the provider's state changes.
  ///
  /// [provider] is also required and is the provider to listen to for changes.
  ///
  /// Optional parameters include:
  /// - [onSuccess] for handling successful data retrieval.
  /// - [onError] for handling errors.
  /// - [showLoading] to control whether a loading indicator is shown.
  /// - [blockScreenWhileLoading] to control whether the screen is blocked during loading.
  /// - [showErrorMessage] to control whether error messages are displayed.
  /// - [errorMessage] to provide a custom error message in case of an error.
  const ProviderListener({
    super.key,
    required this.builder,
    required this.provider,
    this.onSuccess,
    this.onError,
    this.showLoading = true,
    this.blockScreenWhileLoading = false,
    this.showErrorMessage = true,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        ref.listen(provider, (previous, state) {
          if (state is AsyncLoading && showLoading) {
            _showLoaderDialog(
              context,
              emptyDialog: blockScreenWhileLoading,
            );
          } else if (state is AsyncData) {
            _onAsyncData(context, ref, state.requireValue);
          } else if (state is AsyncError) {
            _onAsyncError(context, ref, state);
          }
        });
        return builder(context, ref);
      },
    );
  }

  /// Handles the logic when the provider is in the `AsyncData` state.
  ///
  /// This method hides the loading indicator if it was shown,
  /// and calls the [onSuccess] callback if provided.
  void _onAsyncData(BuildContext context, WidgetRef ref, T data) {
    if (showLoading) {
      Navigator.pop(context);
    }
    onSuccess?.call(context, data, ref);
  }

  /// Handles the logic when the provider is in the `AsyncError` state.
  ///
  /// This method hides the loading indicator if it was shown,
  /// and displays an error message if [showErrorMessage] is true.
  /// It also triggers the [onError] callback if provided.
  void _onAsyncError(
    BuildContext context,
    WidgetRef ref,
    AsyncError errorState,
  ) {
    if (showLoading) {
      Navigator.pop(context);
    }
    if (showErrorMessage) {
      final options = AppCore.providerOptions.providerListenerOptions;
      options?.onListenerError
          ?.call(errorMessage ?? errorState.error.toString());
    }

    onError?.call(context, ref);
  }

  /// Displays a loader dialog while data is being fetched.
  ///
  /// This method checks whether the dialog should block the screen
  /// (using a transparent or semi-transparent barrier) and displays
  /// the loader widget specified in the options or a default loader.
  void _showLoaderDialog(BuildContext context, {bool emptyDialog = false}) {
    final options = AppCore.providerOptions.providerListenerOptions;

    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: emptyDialog ? Colors.transparent : Colors.black26,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: emptyDialog
              ? const SizedBox.shrink()
              : Center(
                  child: options?.loading ??
                      const CircularProgressIndicator.adaptive(),
                ),
        );
      },
    );
  }
}
