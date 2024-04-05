
// import 'package:flutter/material.dart';

// class SearchResultModel extends ChangeNotifier {
//   String currentDate;
//   String description;
//   String temperature;

//   SearchResultModel({
//     required this.currentDate,
//     required this.description,
//     required this.temperature,
//   });

//   void update({
//     required String newCurrentDate,
//     required String newDescription,
//     required String newTemperature,
//   }) {
//     currentDate = newCurrentDate;
//     description = newDescription;
//     temperature = newTemperature;
    
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';

class SearchResultModel extends ChangeNotifier {
  String currentDate = '';
  String description = '';
  String temperature = '';

  void updateData({
    required String currentDate,
    required String description,
    required String temperature,
  }) {
    this.currentDate = currentDate;
    this.description = description;
    this.temperature = temperature;
    notifyListeners();
  }
}
