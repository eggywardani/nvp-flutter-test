import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final storage = GetStorage();

  // Initialize the theme mode from storage or default
  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = storage.read('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Function to toggle between light and dark themes
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    storage.write('isDarkMode', isDarkMode.value);
  }
}
