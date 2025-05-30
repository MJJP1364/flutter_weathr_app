// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// const String apikey = '7eba17b6d1974e6fa91163305241804';

// class WeatherscreenController extends GetxController {

//   @override
//   void onInit() {
//      getCurrentWeather(location.value);
//      getHourlyForcast(location.value);
//       getPast7DayWeather(location.value).then((value) {
//         past7DayWeather.value = value;
//       });
//     super.onInit();
//   }

//   final String _baseUrl = 'https://www.weatherapi.com/v1';

//   RxString location = 'Tabriz'.obs;
//   RxString country = 'Iran'.obs;
//   RxString currentTemp = '0'.obs;
//   RxMap<String, dynamic> currentWeather = <String, dynamic>{}.obs;
//   RxList<dynamic> hourly = <dynamic>[].obs;
//   RxList<dynamic> past7DayWeather = <dynamic>[].obs;
//   RxList<dynamic> next7DayWeather = <dynamic>[].obs;
//   RxBool isLoading = false.obs;

//   TextEditingController searchController = TextEditingController();

//   Future<Map<String, dynamic>> getCurrentWeather(String location) async {
//     isLoading.value = true;
//     var data = <String, dynamic>{};
//     final url = Uri.parse(
//       '$_baseUrl/current.json?key=$apikey&q=$location',
//     );
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         isLoading.value = false;
//         if (GetUtils.isNullOrBlank(response.body) == true) {
//           return {};
//         } else {
//           data = Map<String, dynamic>.from(jsonDecode(response.body));
//           currentWeather.value = data['current'];
//           currentTemp.value = data['current']['temp_c'].toString();
//           location = data['location']['name'].obs;
//           country = data['location']['country'].obs;
//           hourly.value = data['forecast']['forecastday'][0]['hour'];
//           next7DayWeather.value = data['forecast']['forecastday'];
//           past7DayWeather.value = await getPast7DayWeather(this.location.value);
//         }
//       } else {
//         isLoading.value = false;
//         throw Exception('Failed to load weather data');
//       }
//     } catch (e) {
//       isLoading.value = false;
//       throw Exception('Error fetching weather data: $e');
//     }
//     return data;
//   }

//   Future<Map<String, dynamic>> getHourlyForcast(String location) async {
//     isLoading.value = true;
//     var data = <String, dynamic>{};
//     final url = Uri.parse(
//       '$_baseUrl/forecast.json?key=$apikey&q=$location&days=7',
//     );
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         isLoading.value = false;
//         if (GetUtils.isNullOrBlank(response.body) == true) {
//           return {};
//         } else {
//           data = Map<String, dynamic>.from(jsonDecode(response.body));
//         }
//       } else {
//         isLoading.value = false;
//         throw Exception('Failed to load weather data');
//       }
//     } catch (e) {
//       isLoading.value = false;
//       throw Exception('Error fetching weather data: $e');
//     }
//     return data;
//   }

//   Future<List<Map<String, dynamic>>> getPast7DayWeather(String location) async {
//     final List<Map<String, dynamic>> past7DayWeather = [];
//     final data = DateTime.now().subtract(Duration(days: 1));
//     final String formattedDate =
//         '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
//     final url = Uri.parse(
//       '$_baseUrl/history.json?key=$apikey&q=$location&dt=$formattedDate',
//     );

//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         if (GetUtils.isNullOrBlank(response.body) == true) {
//           return [];
//         } else {
//           final Map<String, dynamic> jsonData = jsonDecode(response.body);
//           final List<dynamic> forecastDays =
//               jsonData['forecast']['forecastday'];
//           for (var day in forecastDays) {
//             past7DayWeather.add(Map<String, dynamic>.from(day));
//           }
//         }
//       } else {
//         throw Exception('Failed to load past 7 days weather data');
//       }
//     } catch (e) {
//       throw Exception('Error fetching past 7 days weather data: $e');
//     }

//     return past7DayWeather;
//   }
// }

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apikey = '7eba17b6d1974e6fa91163305241804';

class WeatherscreenController extends GetxController {
  final String _baseUrl = 'http://api.weatherapi.com/v1';

  // State Variables
  var location = ''.obs;
  var country = ''.obs;
  var currentTemp = '0'.obs;
  var hourly = <dynamic>[].obs;
  var next7DayWeather = <dynamic>[].obs;
  var past7DayWeather = <dynamic>[].obs;

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

        // Update state with new data
        location.value = data['location']['name'];
        country.value = data['location']['country'];
        currentTemp.value = data['current']['temp_c'].toString();
        hourly.value = data['current']['hour'] ?? [];
        next7DayWeather.value = data['forecast']['forecastday'] ?? [];

        // Fetch and update past weather
        past7DayWeather.value = await getPast7DayWeather(query);
      } else {
        throw Exception(
          'Failed to load weather data (Status: ${response.statusCode})',
        );


       
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
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
