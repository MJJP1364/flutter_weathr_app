import 'package:get/get.dart';
// import 'package:weather_app/Core/Utils/themes/theme_controller.dart';
import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';

class AllBindings implements Bindings {
  @override
  void dependencies() {
    // Add all your controllers here
    Get.lazyPut<WeatherscreenController>(
      () => WeatherscreenController(),
      fenix: true,
    );
  }
}
