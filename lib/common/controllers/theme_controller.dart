import 'package:flutter/material.dart'; // Import for ThemeMode
import 'package:get/get.dart'; // Import GetX for GetxController and Get.changeThemeMode
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart'; // Assuming AppConstants.theme is defined here

class ThemeController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  final _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value; // Getter for the current theme mode

  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }


  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;

    update(); // Trigger UI rebuild for any GetBuilder listeners (though Get.changeThemeMode often handles most UI updates)
  }



  // Toggles the theme between light and dark
  void toggleTheme() {
    _themeMode.value = _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    sharedPreferences.setBool(AppConstants.theme, _themeMode.value == ThemeMode.dark);
    Get.changeThemeMode(_themeMode.value); // Notify GetX to change the app's theme
    update(); // Trigger UI rebuild for any GetBuilder listeners (though Get.changeThemeMode often handles most UI updates)
  }



  void _loadCurrentTheme() async {
    // Load persisted theme preference
    bool? isDark = sharedPreferences.getBool(AppConstants.theme);
    if (isDark != null) {
      _themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      // If no preference is saved, default to system theme or light theme
      _themeMode.value = ThemeMode.system; // Or ThemeMode.light, based on your preference
    }

    // Apply the loaded theme immediately on app start
    Get.changeThemeMode(_themeMode.value);


    update();
  }
}