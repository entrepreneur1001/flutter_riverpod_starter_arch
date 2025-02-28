import 'package:starter_riverpod/src/core/state_managements/utils/provider_options.dart';

class AppCore {
  const AppCore._();

  static ProviderOptions? _options;
  static String? _languageCode;

  static void init({
    ProviderOptions? options,
    required String languageCode,
  }) {
    _options ??= options ?? const ProviderOptions();
  }

  static String get languageCode => _languageCode!;
  static ProviderOptions get providerOptions => _options!;
}
