

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    final geocodingUrl =
        'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=b39c7464ab56df782ab4652f7da5fd99';
    final geocodingResponse = await http.get(Uri.parse(geocodingUrl));

    if (geocodingResponse.statusCode == 200) {
      final geocodingData = jsonDecode(geocodingResponse.body);
      final lat = geocodingData[0]['lat'];
      final lon = geocodingData[0]['lon'];

      final weatherUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=b39c7464ab56df782ab4652f7da5fd99&units=metric';
      final weatherResponse = await http.get(Uri.parse(weatherUrl));

      if (weatherResponse.statusCode == 200) {
        final weatherData = jsonDecode(weatherResponse.body);
        final temp = weatherData['main']['temp'];
        final description = weatherData['weather'][0]['description'];

        return {
          'currentDate': _getCurrentDate(),
          'description': description,
          'temperature': temp.toStringAsFixed(0),
        };
      }
    }
    return {};
  }

  static String _getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    return 'Today, $day $month';
  }
}



// import 'package:flutter/material.dart';

// class SearchResultModel extends ChangeNotifier {
//   String currentDate = '';
//   String description = '';
//   String temperature = '';

//   void updateData({
//     required String currentDate,
//     required String description,
//     required String temperature,
//   }) {
//     this.currentDate = currentDate;
//     this.description = description;
//     this.temperature = temperature;
//     notifyListeners();
//   }
// }
