import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Core/Utils/themes/theme_controller.dart';
import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';
import 'package:weather_app/Pages/widgets/cloud.dart';
import 'package:weather_app/Pages/widgets/humidity.dart';
import 'package:weather_app/Pages/widgets/pressure.dart';
import 'package:weather_app/Pages/widgets/search_widget.dart';
import 'package:weather_app/Pages/widgets/windSpeed.dart';

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
          // return Text(_weatherscreenController.errorMessage.value);
          return Center(
            child: Text(
              'Please enter a valid location',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 25,
              ),
            ),
          );
        }

        return SizedBox(
          width: size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '${_weatherscreenController.location.value} , ${_weatherscreenController.country.value.isNotEmpty ? _weatherscreenController.country : ''}',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_weatherscreenController.currentTemp.value} °C',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // ... other widgets
              // const SizedBox(height: 20),
              Text(
                _weatherscreenController.condition.value.isNotEmpty
                    ? _weatherscreenController.condition.value
                    : 'No condition data',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),

              if (_weatherscreenController.iconUrl.value.isNotEmpty)
                SizedBox(
                  width: size.width * 0.5,
                  child: Image.network(
                    width: 200,
                    height: 200,
                    _weatherscreenController.iconUrl.value,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        size: size.width * 0.3,
                        color: Theme.of(context).colorScheme.error,
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 10,
                        offset: const Offset(1, 1),
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Humidity(
                          weatherscreenController: _weatherscreenController,
                        ),

                        Pressure(
                          weatherscreenController: _weatherscreenController,
                        ),
                        WindSpeed(
                          weatherscreenController: _weatherscreenController,
                        ),

                        // for cloud
                        Cloud(
                          weatherscreenController: _weatherscreenController,
                        ),

                        // for hourly forecast
                        // HourlyForcasts(weatherscreenController: _weatherscreenController),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
