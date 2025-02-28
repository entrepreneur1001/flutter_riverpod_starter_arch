import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../extensions/async_value_extension.dart';
import '../../utils/provider_alias.dart';
import 'base_provider_builder.dart';

/// `ProviderBuilder` is a Flutter `ConsumerStatefulWidget` designed to simplify the process
/// of consuming data from a provider while handling various states such as
/// data loading, success, error, and empty states.
///
/// This widget is particularly useful when you have a provider that does not require
/// external parameters, and you want to handle the different states (loading, error, etc.)
/// in a consistent manner across your application.
///
/// [T] is the type of the data the provider emits.
class ProviderBuilder<T> extends BaseProviderBuilder<T, void> {
  /// Constructor for the `ProviderBuilder` widget.
  ///
  /// [provider] is the provider that supplies the data. It can be either a `Provider`
  /// or a `Family` that does not require parameters.
  ///
  /// [builder] is the function that builds the widget when the data is successfully retrieved.
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
  const ProviderBuilder({
    super.key,
    required super.provider,
    required super.builder,
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
  ConsumerState<BaseProviderBuilder<T, void>> createState() =>
      _ProviderBuilderState<T>();
}

/// `_ProviderBuilderState` manages the state of the `ProviderBuilder` widget.
///
/// This class handles the provider interaction and manages the different states
/// (loading, error, etc.) accordingly.
class _ProviderBuilderState<T> extends BaseProviderBuilderState<T, void> {
  @override
  void initState() {
    super.initState();
    // Automatically call the provider if autoCall is enabled or if the current state
    // indicates an error.
    if ((widget.autoCall && state == null) || state.isErrorState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _call(),
      );
    }
  }

  /// `_call` handles invoking the provider.
  ///
  /// This method checks the type of provider and calls it accordingly.
  void _call() {
    if (widget.provider is BaseStateNotifierType) {
      ref.read((widget.provider as BaseStateNotifierType).notifier).call();
    } else if (widget.provider is BaseStateNotifierAutoDisposeType) {
      ref
          .read((widget.provider as BaseStateNotifierAutoDisposeType).notifier)
          .call();
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
