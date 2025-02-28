import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_riverpod/src/core/state_managements/extensions/async_value_extension.dart';
import 'package:starter_riverpod/src/core/state_managements/state_managment_core.dart';

/// `BaseProviderBuilder` is an abstract Flutter `ConsumerStatefulWidget` that simplifies
/// the process of consuming data from a provider while handling various states such as
/// data loading, success, error, and empty states.
///
/// This base class is designed to be extended by other widgets that need to interact with
/// providers in a consistent manner, handling different states in a uniform way.
///
/// [T] is the type of data the provider emits.
/// [R] is the type of parameters required by the provider, if any.
abstract class BaseProviderBuilder<T, R> extends ConsumerStatefulWidget {
  /// The provider that supplies the data. It can be either a `Provider` or a `Family`.
  final ProviderOrFamily provider;

  /// The builder function that is called on successful data retrieval.
  /// It provides the retrieved data of type [T] and the `WidgetRef`.
  final Widget Function(T data, WidgetRef ref) builder;

  /// A custom widget to be displayed when the state is in its initial state.
  /// This is valid only in `StateNotifier` providers.
  final Widget? initialView;

  /// A custom widget to be displayed as a loading indicator.
  final Widget? loadingView;

  /// A custom widget to be displayed when the data is empty.
  final Widget? emptyView;

  /// A builder function that is called in case of an error.
  /// It provides the `TWFailure` representing the error and the `WidgetRef`.
  final Widget Function(WidgetRef ref)? errorBuilder;

  /// A flag to skip displaying the loading indicator when refreshing data.
  final bool skipLoadingOnRefresh;

  /// A callback function that is called in case of an error state.
  /// Represents an action to be taken when an error occurs.
  final VoidCallback? onError;

  /// A flag to determine whether to display a loading indicator during data fetching.
  final bool showLoading;

  /// A flag to center the error view.
  final bool centerErrorView;

  /// A flag to auto-call the provider method by default.
  final bool autoCall;

  /// Constructor for the `BaseProviderBuilder` widget.
  ///
  /// [provider] is the provider that supplies the data.
  /// [builder] is the function that builds the widget when the data is successfully retrieved.
  ///
  /// Optional parameters include:
  /// - [initialView] for the initial state view.
  /// - [loadingView] for the loading state view.
  /// - [emptyView] for the empty state view.
  /// - [errorBuilder] for building the view when an error occurs.
  /// - [skipLoadingOnRefresh] to control whether the loading indicator is shown on refresh.
  /// - [onError] callback when an error occurs.
  /// - [centerErrorView] to center the error view widget.
  /// - [showLoading] to control the visibility of the loading indicator.
  /// - [autoCall] to automatically call the provider when the widget is initialized.
  const BaseProviderBuilder({
    super.key,
    required this.provider,
    required this.builder,
    this.initialView,
    this.loadingView,
    this.emptyView,
    this.errorBuilder,
    this.skipLoadingOnRefresh = false,
    this.onError,
    this.centerErrorView = false,
    this.showLoading = true,
    this.autoCall = true,
  }) : assert(
          provider is ProviderListenable<AsyncValue<T>?>,
          'The provider should be ProviderListenable<AsyncValue<T>?>',
        );

  @override
  ConsumerState<BaseProviderBuilder<T, R>> createState();
}

/// `BaseProviderBuilderState` is an abstract class that manages the state of
/// the `BaseProviderBuilder` widget.
///
/// This class handles the initialization of the provider, watches for state changes,
/// and manages the display of different views based on the current state.
abstract class BaseProviderBuilderState<T, R>
    extends ConsumerState<BaseProviderBuilder<T, R>> {
  late final ProviderListenable<AsyncValue<T>?> _providerListenable;
  late final AsyncValue<T>? state;
  Widget? _loadingView;
  Widget? _errorView;

  @override
  void initState() {
    super.initState();
    // Initialize the provider listenable from the widget's provider.
    _providerListenable = widget.provider as ProviderListenable<AsyncValue<T>?>;
    state = ref.read<AsyncValue<T>?>(_providerListenable);
    final options = AppCore.providerOptions.providerBuilderOptions;
    _loadingView = widget.loadingView ?? options?.loadingView;
    _errorView = options?.errorView;
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider's state for changes.
    final state = ref.watch<AsyncValue<T>?>(_providerListenable);

    // Display the initial view if the state is in its initial state.
    if (state?.isInitialState ?? false) {
      return widget.initialView ?? const SizedBox.shrink();
    }

    // Handle the empty state by displaying the empty view or an empty widget.
    if (state.isEmptyState) return widget.emptyView ?? const SizedBox.shrink();

    // Display the appropriate view based on the current state.
    return state!.when(
      data: (T data) => widget.builder(data, ref),
      error: (error, stackTrace) => _errorView ?? Text(error.toString()),
      loading: () => Visibility(
        visible: widget.showLoading,
        child: Center(
          child: _loadingView ?? const CircularProgressIndicator.adaptive(),
        ),
      ),
      skipLoadingOnRefresh: widget.skipLoadingOnRefresh,
    );
  }
}
