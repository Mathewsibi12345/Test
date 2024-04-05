

// import 'package:flutter/material.dart';
// import 'package:flutter_application_weather_app/model/city.dart';
// import 'package:flutter_application_weather_app/services.dart';
// import 'package:provider/provider.dart';


// class SearchResultController {
//   final BuildContext context;

//   SearchResultController(this.context);

//   Future<void> fetchWeatherData(String city) async {
//     final weatherData = await WeatherService.fetchWeatherData(city);
//     final model = SearchResultModel(
//       // currentDate: weatherData['currentDate'] ?? '',
//       // description: weatherData['description'] ?? '',
//       // temperature: weatherData['temperature'] ?? '',
//     );
//     Provider.of<SearchResultModel>(context, listen: false).(model);
//   }
// }
