import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inapps_picasso/app/app.dart';
import 'package:inapps_picasso/shared/util/logger.dart';
import 'package:inapps_picasso/shared/util/platform_type.dart';

Locale defaultLocale = const Locale('en');

Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final platformType = detectPlatformType();

  runApp(EasyLocalization(
    supportedLocales: [defaultLocale],
    path: 'assets/languages',
    fallbackLocale: defaultLocale,
    useOnlyLangCode: true,
    startLocale: defaultLocale,
    child: ProviderScope(overrides: [
      platformTypeProvider.overrideWithValue(platformType),
    ], observers: [
      Logger()
    ], child: const App(),),
  ),);
}
