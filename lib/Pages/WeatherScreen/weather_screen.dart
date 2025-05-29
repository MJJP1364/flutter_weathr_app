import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Core/Utils/themes/theme_controller.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: _themeController.toggleTheme,
              icon: Obx(
                () => Icon(
                  _themeController.isDarkMode.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color:
                      _themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(child: Text('Welcome to the Weather App')),
    );
  }
}
