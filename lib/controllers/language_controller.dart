import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _storage = GetStorage();
  final isIndonesian = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved language from storage
    final savedLanguage = _storage.read('language') ?? 'en';
    Get.updateLocale(Locale(savedLanguage));
    isIndonesian.value = savedLanguage == 'id';
  }

  Locale loadLanguage() {
    // Load language setting from storage when app starts
    final savedLanguage = _storage.read('language') ?? 'en';
    return Locale(savedLanguage);
  }

  void toggleLanguage() {
    if (Get.locale?.languageCode == 'id') {
      // Change to English
      Get.updateLocale(const Locale('en', 'US'));
      isIndonesian.value = false;
      _storage.write('language', 'en');
    } else {
      // Change to Indonesian
      Get.updateLocale(const Locale('id', 'ID'));
      isIndonesian.value = true;
      _storage.write('language', 'id');
    }
  }
}
