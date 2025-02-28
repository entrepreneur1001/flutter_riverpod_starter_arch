import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider_listener/provider_listener.dart';

/// `ProviderConsumer` is a Flutter StatelessWidget that combines the functionalities
/// of `ProviderListener` and `ProviderBuilder` to simplify the process of
/// consuming data from a provider, handling loading, success, and error states.

abstract class BaseProviderConsumer<T, R> extends StatelessWidget {
  /// The provider that supplies the data. It can be either a `Provider` or a `Family`.
  final ProviderOrFamily provider;

  /// Builder function called on successful data retrieval. It provides the
  /// retrieved data of type `T` and the `WidgetRef`.
  final Widget Function(T data, WidgetRef ref) builder;

  /// Builder function called in case of an error. It provides the `TWFailure`
  /// representing the error and the `WidgetRef`.
  final Widget Function(WidgetRef ref)? errorBuilder;

  /// Custom widget to be displayed as a loading indicator.
  final Widget? loadingView;

  /// Custom widget to be displayed when the data is empty.
  final Widget? emptyView;

  /// Flag to skip displaying the loading indicator when refreshing data.
  final bool skipLoadingOnRefresh;

  /// Callback function called on successful data retrieval. It provides the
  /// `BuildContext`, the retrieved data of type `T`, and the `WidgetRef`.
  final void Function(BuildContext context, T data, WidgetRef ref)? onSuccess;

  /// Callback function called in case of an error. It provides the `BuildContext`,
  /// the `WidgetRef`, and the `TWFailure` representing the error.
  final void Function(BuildContext context, WidgetRef ref)? onError;

  /// Flag to determine whether to display a loading indicator during data fetching.
  final bool showLoading;

  /// Flag to  to call Future auto bu default true
  final bool autoCall;

  /// Constructor for `ProviderConsumer` widget.
  const BaseProviderConsumer({
    super.key,
    required this.builder,
    required this.provider,
    this.onSuccess,
    this.onError,
    this.showLoading = false,
    this.errorBuilder,
    this.loadingView,
    this.emptyView,
    this.skipLoadingOnRefresh = false,
    this.autoCall = true,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderListener<T>(
      provider: provider as ProviderListenable<AsyncValue<T>?>,
      onSuccess: onSuccess,
      onError: onError,
      showErrorMessage: false,
      showLoading: false,
      builder: buildProviderBuilder,
    );
  }

  /// Abstract method to build the ProviderBuilder.
  /// Subclasses should implement this method to handle the specifics of with/without params.
  Widget buildProviderBuilder(BuildContext context, WidgetRef ref);
}
