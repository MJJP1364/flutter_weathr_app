import 'package:get/get.dart';
import 'package:weather_app/Pages/Home/home_view.dart';
import 'package:weather_app/Pages/spalash/splash_screen.dart';

List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => const HomePage(),
    // binding: HomeBinding(),
  ),

  GetPage(
    name: '/splash',
    page: () => const SplashScreen(),
    // binding: SplashBinding(),
  ),

  // GetPage(
  //   name: '/login',
  //   page: () => const LoginPage(),
  //   binding: LoginBinding(),
  // ),
  // GetPage(
  //   name: '/register',
  //   page: () => const RegisterPage(),
  //   binding: RegisterBinding(),
  // ),
  // GetPage(
  //   name: '/profile',
  //   page: () => const ProfilePage(),
  //   binding: ProfileBinding(),
  // ),
  // GetPage(
  //   name: '/settings',
  //   page: () => const SettingsPage(),
  //   binding: SettingsBinding(),
  // ),
];
