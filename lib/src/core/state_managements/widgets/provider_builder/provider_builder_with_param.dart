import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/async_value_extension.dart';
import '../../utils/provider_alias.dart';
import 'base_provider_builder.dart';

/// `ProviderBuilderWithParam` is a Flutter `ConsumerStatefulWidget` designed to simplify
/// the process of consuming data from a provider that requires parameters while handling
/// various states such as data loading, success, error, and empty states.
///
/// This widget is particularly useful when you have a provider that depends on external
/// parameters and you want to handle the different states (loading, error, etc.)
/// in a consistent manner across your application.
///
/// [T] is the type of the data the provider emits.
/// [R] is the type of the parameters that the provider requires.
class ProviderBuilderWithParam<T, R> extends BaseProviderBuilder<T, R> {
  /// The parameters that will be passed to the provider.
  final R param;

  /// Constructor for the `ProviderBuilderWithParam` widget.
  ///
  /// [provider] is the provider that supplies the data. It can be either a `Provider`
  /// or a `Family` that requires parameters.
  ///
  /// [builder] is the function that builds the widget when the data is successfully retrieved.
  ///
  /// [param] are the parameters required by the provider. These are passed when calling the provider.
  ///
  /// Other optional parameters include:
  /// - [initialView] for the initial state view.
  /// - [loadingView] for the loading state view.
  /// - [emptyView] for the empty state view.
  /// - [errorBuilder] for building the view when an error occurs.
  /// - [skipLoadingOnRefresh] to control whether the loading indicator is shown on refresh.
  /// - [onError] callback when an error occurs.
  /// - [centerErrorView] to center the error view widget.
  /// - [showLoading] to control the visibility of the loading indicator.
  /// - [autoCall] to automatically call the provider when the widget is initialized.
  const ProviderBuilderWithParam({
    super.key,
    required super.provider,
    required super.builder,
    required this.param, // Make params required
    super.initialView,
    super.loadingView,
    super.emptyView,
    super.errorBuilder,
    super.skipLoadingOnRefresh,
    super.onError,
    super.centerErrorView,
    super.showLoading,
    super.autoCall,
  });

  @override
  ConsumerState<BaseProviderBuilder<T, R>> createState() =>
      _ProviderBuilderState<T, R>();
}

/// `_ProviderBuilderState` manages the state of the `ProviderBuilderWithParam` widget.
///
/// This class handles the initialization of the provider with the required parameters and
/// manages the different states (loading, error, etc.) accordingly.
class _ProviderBuilderState<T, R> extends BaseProviderBuilderState<T, R> {
  late final R params;

  @override
  void initState() {
    super.initState();
    // Initialize the params field by accessing it from the widget.
    params = (widget as ProviderBuilderWithParam<T, R>).param;

    // Automatically call the provider with the given parameters if autoCall is enabled
    // or if the current state indicates an error.
    if ((widget.autoCall && state == null) || state.isErrorState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _call(),
      );
    }
  }

  /// `_call` handles invoking the provider with the required parameters.
  ///
  /// This method checks the type of provider and calls it with the stored parameters [params].
  void _call() {
    if (widget.provider is BaseStateNotifierWithParamsType<T, R>) {
      ref
          .read(
            (widget.provider as BaseStateNotifierWithParamsType<T, R>).notifier,
          )
          .call(params);
    } else if (widget.provider
        is BaseStateNotifierAutoDisposeWithParamsType<T, R>) {
      ref
          .read(
            (widget.provider
                    as BaseStateNotifierAutoDisposeWithParamsType<T, R>)
                .notifier,
          )
          .call(params);
    } else if (widget.provider is FutureProvider) {
      return ref.refresh((widget.provider as FutureProvider).future);
    } else if (widget.provider is AutoDisposeFutureProvider) {
      return ref.refresh((widget.provider as AutoDisposeFutureProvider).future);
    } else {
      // Invalidate the provider to refresh its data.
      ref.invalidate(widget.provider);
    }
  }
}
