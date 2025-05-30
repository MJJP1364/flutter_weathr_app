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
                  width: size.width * 0.8,
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
                        Column(
                          // for humidity
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Humidity',
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                fontSize: 12,
                              ),
                            ),
                            Obx(
                              () => Text(
                                '${_weatherscreenController.humidity.value}%',
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
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
                        ),

                        Column(
                          // for pressure
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pressure',
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                fontSize: 12,
                              ),
                            ),
                            Obx(
                              () => Text(
                                '${_weatherscreenController.pressure.value} hPa',
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
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
                        ),
                        Column(
                          // for wind speed
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Wind Speed',
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                fontSize: 12,
                              ),
                            ),
                            Obx(
                              () => Text(
                                '${_weatherscreenController.windSpeed.value} km/h',
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/512/5918/5918654.png',
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
                        ),

                        // for cloud
                        Column(
                          // for cloud
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cloud',
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                fontSize: 12,
                              ),
                            ),
                            Obx(
                              () => Text(
                                '${_weatherscreenController.cloud.value}%',
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/512/4834/4834559.png',
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
                        ),

                        // for max temprature
                        // Column(
                        //   // for max temperature
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       'Max Temp',
                        //       style: TextStyle(
                        //         color:
                        //             Theme.of(
                        //               context,
                        //             ).textTheme.bodyLarge?.color,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //     Obx(
                        //       () => Text(
                        //         '${_weatherscreenController.maxTemp.value} °C',
                        //         style: TextStyle(
                        //           color:
                        //               Theme.of(
                        //                 context,
                        //               ).textTheme.bodyLarge?.color,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     Image.network(
                        //       'https://cdn-icons-png.flaticon.com/512/6281/6281340.png',
                        //       width: 30,
                        //       height: 30,
                        //       errorBuilder: (context, error, stackTrace) {
                        //         return Icon(
                        //           Icons.error,
                        //           size: 30,
                        //           color: Theme.of(context).colorScheme.error,
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // for hourly forecast
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       'Hourly Forecast',
                        //       style: TextStyle(
                        //         color:
                        //             Theme.of(
                        //               context,
                        //             ).textTheme.bodyLarge?.color,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //     Obx(
                        //       () => Text(
                        //         '${_weatherscreenController.hourlyForecast.length} hours',
                        //         style: TextStyle(
                        //           color:
                        //               Theme.of(
                        //                 context,
                        //               ).textTheme.bodyLarge?.color,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     Image.network(
                        //       'https://cdn-icons-png.flaticon.com/512/1046/1046784.png',
                        //       width: 30,
                        //       height: 30,
                        //       errorBuilder: (context, error, stackTrace) {
                        //         return Icon(
                        //           Icons.error,
                        //           size: 30,
                        //           color: Theme.of(context).colorScheme.error,
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
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
