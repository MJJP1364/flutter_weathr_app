import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/Core/Utils/themes/theme_controller.dart';
import 'package:weather_app/Core/Utils/themes/themes.dart';
import 'package:weather_app/Core/dependences/dependences.dart';
import 'package:weather_app/Pages/spalash/splash_screen.dart';
// import 'Pages/Home/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  Get.put(ThemeController());

  runApp(const FlutterWeatherApp());
}

//<<<<<<< HEAD
class FlutterWeatherApp extends StatelessWidget {
  const FlutterWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Weather App',
      initialBinding: AllBindings(),

      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: Get.find<ThemeController>().theme,

      //--------------------------------------------------------------
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
