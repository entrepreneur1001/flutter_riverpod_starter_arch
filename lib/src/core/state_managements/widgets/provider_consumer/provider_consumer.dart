import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider_builder/provider_builder.dart';
import 'base_provider_consumer.dart';

/// `ProviderConsumer` is a Flutter `StatelessWidget` that extends `BaseProviderConsumer`
/// and is designed to simplify the process of consuming data from a provider that does not
/// require additional parameters. It combines the functionalities of listening to a provider
/// and building the UI based on the provider's state.
///
/// This widget handles various states such as loading, success, and error, providing a consistent
/// way to manage these states across your application.
///
/// [T] is the type of data the provider emits.
class ProviderConsumer<T> extends BaseProviderConsumer<T, void> {
  /// Constructor for `ProviderConsumer`.
  ///
  /// [builder] is required and is the function that builds the widget when the provider's state changes.
  ///
  /// [provider] is also required and is the provider to listen to for changes.
  ///
  /// Optional parameters include:
  /// - [onSuccess] for handling successful data retrieval.
  /// - [onError] for handling errors.
  /// - [showLoading] to control whether a loading indicator is shown.
  /// - [errorBuilder] to customize the error view.
  /// - [loadingView] to customize the loading view.
  /// - [emptyView] to customize the view when the data is empty.
  /// - [skipLoadingOnRefresh] to control whether the loading indicator is shown when refreshing data.
  /// - [autoCall] to automatically call the provider when the widget is initialized.
  const ProviderConsumer({
    super.key,
    required super.builder,
    required super.provider,
    super.onSuccess,
    super.onError,
    super.showLoading = false,
    super.errorBuilder,
    super.loadingView,
    super.emptyView,
    super.skipLoadingOnRefresh = false,
    super.autoCall = true,
  });

  /// Builds the `ProviderBuilder` widget to manage the UI based on the provider's state.
  ///
  /// This method overrides the `buildProviderBuilder` method from `BaseProviderConsumer`
  /// and constructs a `ProviderBuilder` widget that handles the different states of the provider.
  ///
  /// [context] is the `BuildContext` of the widget.
  /// [ref] is the `WidgetRef` used to access the provider.
  ///
  /// Returns a `ProviderBuilder` widget that listens to the provider's state and builds the UI accordingly.
  @override
  Widget buildProviderBuilder(BuildContext context, WidgetRef ref) {
    return ProviderBuilder<T>(
      provider: provider,
      builder: builder,
      autoCall: autoCall,
      showLoading: showLoading,
      errorBuilder: errorBuilder,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      emptyView: emptyView,
      loadingView: loadingView,
    );
  }
}
