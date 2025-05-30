import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apikey = '7eba17b6d1974e6fa91163305241804';

class WeatherscreenController extends GetxController {
  final String _baseUrl = 'http://api.weatherapi.com/v1';

  // State Variables
  var location = 'Tabriz'.obs;
  var country = ''.obs;
  var condition = ''.obs;
  var iconUrl = ''.obs;
  var currentTemp = '0'.obs;
  var hourly = <dynamic>[].obs;
  var next7DayWeather = <dynamic>[].obs;
  var past7DayWeather = <dynamic>[].obs;
  RxInt humidity = 0.obs;
  RxInt windSpeed = 0.obs; // Uncomment if you want to use wind speed
  RxInt pressure = 0.obs; // Uncomment if you want to use pressure
  RxString maxTemp = ''.obs;
  final RxList<dynamic> hourlyForecast = <dynamic>[].obs;
  RxInt cloud = 0.obs;

  // Loading & Error Handling
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getCurrentWeather(location.value);
    super.onInit();
  }

  Future<void> getCurrentWeather(String query) async {
    if (isLoading.isTrue) return; // Prevent multiple calls

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final url = Uri.parse('$_baseUrl/current.json?key=$apikey&q=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        // 1️⃣ چک کردن location

        final locationData = data['location'] as Map<String, dynamic>?;
        if (locationData != null) {
          location.value = locationData['name'] ?? 'Unknown';
          country.value = locationData['country'] ?? 'Unknown';
          // condition.value = locationData['condition']['text'] ?? 'Unknown';
        }

        // 2️⃣ چک کردن current
        final currentData = data['current'] as Map<String, dynamic>?;
        if (currentData != null) {
          currentTemp.value = currentData['temp_c']?.toString() ?? '0';
          hourly.value = currentData['hour'] as List? ?? [];
        }
        // 2️⃣ چک کردن condition
        final conditionData =
            currentData?['condition'] as Map<String, dynamic>?;
        if (conditionData != null) {
          condition.value = conditionData['text'] ?? 'Unknown';
          iconUrl.value = conditionData['icon'] ?? '';
        }
        // 2️⃣ چک کردن iconUrl
        if (iconUrl.value.isNotEmpty) {
          iconUrl.value = 'http:${iconUrl.value}';
        } else {
          iconUrl.value =
              'http://cdn.weatherapi.com/weather/64x64/day/113.png'; // Default icon
        }
        // 2️⃣ چک کردن humidity
        humidity.value = currentData?['humidity'] ?? 0;
        // 2️⃣ چک کردن windSpeed
        windSpeed.value =
            currentData?['wind_kph']?.round() ??
            0; // Uncomment if you want to use wind speed
        // 2️⃣ چک کردن pressure
        pressure.value =
            currentData?['pressure_mb']?.round() ??
            0; // Uncomment if you want to use pressure

        // 2️⃣ چک کردن cloud
        cloud.value = currentData?['cloud'] ?? 0;

        // 2️⃣ چک کردن maxTemp
        maxTemp.value = currentData?['maxtemp_c']?.toString() ?? '0';

        // 2️⃣ چک کردن hourlyForecast
        final hourlyData = currentData?['hour'] as List? ?? [];
        hourlyForecast.value =
            hourlyData.map((hour) => Map<String, dynamic>.from(hour)).toList();

        // 3️⃣ چک کردن forecast
        final forecastData = data['forecast'] as Map<String, dynamic>?;
        if (forecastData != null) {
          next7DayWeather.value = forecastData['forecastday'] as List? ?? [];
        } else {
          next7DayWeather.value = []; // لیست خالی در صورت عدم وجود
        }

        // 4️⃣ دریافت سابقه هوا
        past7DayWeather.value = await getPast7DayWeather(query);
      } else {
        throw Exception(
          'Failed to load weather data (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      errorMessage.value = "Failed to load weather data";
      // Get.snackbar(
      //   "Error",
      //   errorMessage.value,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      // print('Error fetching current weather: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> getPast7DayWeather(String query) async {
    final endDate = DateTime.now().subtract(const Duration(days: 1));
    final formattedDate =
        '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';

    final url = Uri.parse(
      '$_baseUrl/history.json?key=$apikey&q=$query&dt=$formattedDate',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final forecastDays = jsonData['forecast']['forecastday'] as List? ?? [];

      return forecastDays.map((day) => Map<String, dynamic>.from(day)).toList();
    } else {
      throw Exception('Failed to load past weather (History)');
    }
  }

  // Optional: Search method for searching cities
  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;
    await getCurrentWeather(query);
  }
}
