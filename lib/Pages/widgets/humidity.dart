import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';

class Humidity extends StatelessWidget {
  const Humidity({
    super.key,
    required WeatherscreenController weatherscreenController,
  }) : _weatherscreenController = weatherscreenController;

  final WeatherscreenController _weatherscreenController;

  @override
  Widget build(BuildContext context) {
    return Column(
      // for humidity
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Humidity',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 12,
          ),
        ),
        Obx(
          () => Text(
            '${_weatherscreenController.humidity.value}%',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Image.network(
          'https://cdn-icons-png.flaticon.com/512/728/728093.png',
          width: 30,
          height: 30,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.error,
              size: 30,
              color: Theme.of(context).colorScheme.error,
            );
          },
        ),
      ],
    );
  }
}
