// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:weather_app/Core/Utils/themes/theme_controller.dart';
// import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';

// class SearchBox extends StatelessWidget {
//   const SearchBox({
//     super.key,
//     required this.size,
//     required WeatherscreenController weatherscreenController,
//     required ThemeController themeController,
//   }) : _weatherscreenController = weatherscreenController,
//        _themeController = themeController;

//   final Size size;
//   final WeatherscreenController _weatherscreenController;
//   final ThemeController _themeController;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: size.width * 0.8,
//       height: size.height * 0.06,
//       child: TextField(
//         controller: _weatherscreenController.searchController,
//         style: TextStyle(
//           color:
//               _themeController.isDarkMode.value
//                   ? Theme.of(context).textTheme.bodyLarge?.color
//                   : Colors.black87,

//           fontSize: 20,
//         ),
//         onSubmitted: (value) {
//           if (value.isEmpty) {
//             Get.snackbar(
//               'Error',
//               'Please enter a city name',
//               snackPosition: SnackPosition.BOTTOM,
//             );
//             return;
//           }
//           _weatherscreenController.getCurrentWeather(value);
//         },
//         decoration: InputDecoration(
//           prefixIcon: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Icon(
//               Icons.search,
//               color:
//                   _themeController.isDarkMode.value
//                       ? Theme.of(context).textTheme.bodyMedium?.color
//                       : Colors.black54,
//             ),
//           ),
//           hintText: 'Search for a city',
//           hintStyle: TextStyle(
//             color:
//                 _themeController.isDarkMode.value
//                     ? Theme.of(context).textTheme.bodyMedium?.color
//                     : Colors.black54,

//             fontSize: 16,
//           ),

//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide(
//               width: 2,
//               color:
//                   _themeController.isDarkMode.value
//                       ? Theme.of(context).primaryColorLight
//                       : Colors.black54,
//             ),
//           ),

//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Core/Utils/themes/theme_controller.dart';
import 'package:weather_app/Pages/WeatherScreen/weatherScreen_controller.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.size,
    required WeatherscreenController weatherscreenController,
    required ThemeController themeController,
  }) : _weatherscreenController = weatherscreenController,
       _themeController = themeController;

  final Size size;
  final WeatherscreenController _weatherscreenController;
  final ThemeController _themeController;

  // Add this RxString to hold the search text
  static final RxString _searchText = ''.obs;

  @override
  Widget build(BuildContext context) {
    // Set up debounce on the RxString
    ever<String>(_searchText, (value) {
      if (value.trim().isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _onSearch(value);
        });
      }
    });

    return SizedBox(
      width: size.width * 0.8,
      height: size.height * 0.06,
      child: TextField(
        controller: _weatherscreenController.searchController,
        onChanged: (value) {
          _searchText.value = value;
        },
        style: TextStyle(
          color:
              _themeController.isDarkMode.value
                  ? Theme.of(context).textTheme.bodyLarge?.color
                  : Colors.black87,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search,
              color:
                  _themeController.isDarkMode.value
                      ? Theme.of(context).textTheme.bodyMedium?.color
                      : Colors.black54,
            ),
          ),
          hintText: 'Search for a city',
          hintStyle: TextStyle(
            color:
                _themeController.isDarkMode.value
                    ? Theme.of(context).textTheme.bodyMedium?.color
                    : Colors.black54,
            fontSize: 16,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color:
                  _themeController.isDarkMode.value
                      ? Theme.of(context).primaryColorLight
                      : Colors.black54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
      ),
    );
  }

  void _onSearch(String value) {
    if (value.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a city name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _weatherscreenController.getCurrentWeather(value);
  }
}
