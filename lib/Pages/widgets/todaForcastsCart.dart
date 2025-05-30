import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Core/Utils/themes/theme_controller.dart';
// import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';

// ignore: must_be_immutable
class TodayForecastCard extends StatelessWidget {
  List hourly;
  TodayForecastCard({super.key, required this.hourly});

  String formatTime(String timeString) {
    final DateTime time = DateTime.parse(timeString);
    return DateFormat.j().format(time);
  }

  // final WeatherscreenController _weatherscreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    // hourly = _weatherscreenController.;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 250,
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
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today Forecast',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Weekly Forecast',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color:
                  Get.find<ThemeController>().isDarkMode.value
                      ? Colors.white
                      : Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourly.length,
                itemBuilder: (context, index) {
                  final hour = hourly[index];
                  final now = DateTime.now();
                  final hourTime = DateTime.parse(hour['time']);
                  final isCurrentHour =
                      now.hour == hourTime.hour && now.day == hourTime.day;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color:
                            isCurrentHour
                                ? Colors.orangeAccent
                                : Colors.black38,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          Text(
                            isCurrentHour ? 'Now' : formatTime(hour['time']),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
