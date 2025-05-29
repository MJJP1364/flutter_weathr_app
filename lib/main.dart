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

  runApp(const FlutterWeatherApp());
}

class FlutterWeatherApp extends StatelessWidget {
  const FlutterWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Weather App',

      themeMode: ThemeController().theme,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,

      // theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      //--------------------------------------------------------------
      initialBinding: AllBindings(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
