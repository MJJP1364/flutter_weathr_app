
import 'package:get/get.dart';
import 'package:weather_app/Pages/Home/home_controller.dart';

class AllBindings implements Bindings {
  @override
  void dependencies() {
    // Add all your controllers here
    Get.lazyPut<HomeController>(() => HomeController() , fenix: true);
    
  }
}