import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Core/Utils/themes/theme_controller.dart';
import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';
import 'package:weather_app/Pages/widgets/search_widget.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final ThemeController _themeController = Get.find();
  final WeatherscreenController _weatherscreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,

        title: SearchBox(
          size: size,
          weatherscreenController: _weatherscreenController,
          themeController: _themeController,
        ),
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
      body: Obx(() {
        if (_weatherscreenController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (_weatherscreenController.errorMessage.isNotEmpty) {
          return Text(_weatherscreenController.errorMessage.value);
        }

        return Column(
          children: [
            Text('Location: ${_weatherscreenController.location.value}'),
            Text(
              'Temperature: ${_weatherscreenController.currentTemp.value} °C',
            ),
            // ... other widgets
          ],
        );
      }),
    );
  }
}
