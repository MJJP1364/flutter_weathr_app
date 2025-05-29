// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class ThemeController extends GetxController {
//   final _box = GetStorage();
//   final _key = 'isDarkMode';

//   ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

//   bool _loadTheme() => _box.read(_key) ?? false;

//   void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

//   void changeTheme(ThemeData theme) {
//     Get.changeTheme(theme);
//     debugPrint(theme.toString());
//     update();
//   }

//   void changeThemeMode(ThemeMode themeMode) {
//     Get.changeThemeMode(themeMode);
//     update();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // متغیر واکنش‌گر
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme(); // بارگذاری تم در ابتدا
  }

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode(!isDarkMode.value);
    saveTheme(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void saveTheme(bool value) => _box.write(_key, value);

  void loadTheme() {
    isDarkMode(_box.read<bool>(_key) ?? false);
  }
}
