import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';

class Pressure extends StatelessWidget {
  const Pressure({
    super.key,
    required WeatherscreenController weatherscreenController,
  }) : _weatherscreenController = weatherscreenController;

  final WeatherscreenController _weatherscreenController;

  @override
  Widget build(BuildContext context) {
    return Column(
      // for pressure
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pressure',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 12,
          ),
        ),
        Obx(
          () => Text(
            '${_weatherscreenController.pressure.value} hPa',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Image.network(
          'https://cdn-icons-png.freepik.com/256/4117/4117372.png?uid=R132472831&ga=GA1.1.1207369067.1748603320&semt=ais_incoming',
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
