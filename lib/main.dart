import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nvp_test/controllers/theme_controller.dart';
import 'package:nvp_test/firebase_options.dart';
import 'package:nvp_test/theme/app_theme.dart';
import 'package:nvp_test/views/pages/splash/splash_page.dart';

import 'controllers/language_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  final LanguageController languageController = Get.put(LanguageController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'NVP Test',
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        theme: lightTheme,
        supportedLocales: const [
          Locale('en'),
          Locale('id'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        darkTheme: darkTheme,
        locale: languageController.loadLanguage(),
        fallbackLocale: const Locale('en', 'US'),
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}
