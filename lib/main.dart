import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Core/dependences/dependences.dart';
import 'Pages/Home/home_view.dart';

void main() {
  runApp(const FlutterWeatherApp());
}

class FlutterWeatherApp extends StatelessWidget {
  const FlutterWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Weather App',

      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialBinding: AllBindings(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
