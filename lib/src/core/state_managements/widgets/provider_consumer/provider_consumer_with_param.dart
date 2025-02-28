import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider_builder/provider_builder_with_param.dart';
import 'base_provider_consumer.dart';

/// `ProviderConsumerWithParam` is a Flutter `StatelessWidget` that extends `BaseProviderConsumer`
/// and is designed to simplify the process of consuming data from a provider that requires
/// additional parameters. It combines the functionalities of listening to a provider
/// and building the UI based on the provider's state, with support for parameterized providers.
///
/// This widget handles various states such as loading, success, and error, providing a consistent
/// way to manage these states across your application.
///
/// [T] is the type of data the provider emits.
/// [R] is the type of the parameters required by the provider.
class ProviderConsumerWithParam<T, R> extends BaseProviderConsumer<T, R> {
  /// The parameters required by the provider.
  final R param;

  /// Constructor for `ProviderConsumerWithParam`.
  ///
  /// [param] is required and specifies the parameters to be passed to the provider.
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
  const ProviderConsumerWithParam({
    super.key,
    required this.param,
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

  /// Builds the `ProviderBuilderWithParam` widget to manage the UI based on the provider's state
  /// and the provided parameters.
  ///
  /// This method overrides the `buildProviderBuilder` method from `BaseProviderConsumer`
  /// and constructs a `ProviderBuilderWithParam` widget that handles the different states
  /// of the provider, using the provided parameters.
  ///
  /// [context] is the `BuildContext` of the widget.
  /// [ref] is the `WidgetRef` used to access the provider.
  ///
  /// Returns a `ProviderBuilderWithParam` widget that listens to the provider's state
  /// and builds the UI accordingly, with the specified parameters.
  @override
  Widget buildProviderBuilder(BuildContext context, WidgetRef ref) {
    return ProviderBuilderWithParam<T, R>(
      provider: provider,
      builder: builder,
      param: param,
      autoCall: autoCall,
      showLoading: showLoading,
      errorBuilder: errorBuilder,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      emptyView: emptyView,
      loadingView: loadingView,
    );
  }
}
