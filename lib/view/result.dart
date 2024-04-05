import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  final String searchTerm;

  const SearchResult({Key? key, required this.searchTerm}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late TextEditingController _searchController;
  String _currentDate = '';
  String _description = '';
  String _temperature = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchTerm);
    _fetchWeatherData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeatherData() async {
    // Fetch latitude and longitude for the given city using Geocoding API
    final geocodingUrl =
        'http://api.openweathermap.org/geo/1.0/direct?q=${widget.searchTerm}&limit=1&appid=b39c7464ab56df782ab4652f7da5fd99';
    final geocodingResponse = await http.get(Uri.parse(geocodingUrl));

    if (geocodingResponse.statusCode == 200) {
      final geocodingData = jsonDecode(geocodingResponse.body);
      final lat = geocodingData[0]['lat'];
      final lon = geocodingData[0]['lon'];

      // Fetch current weather data using latitude and longitude
      final weatherUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=b39c7464ab56df782ab4652f7da5fd99&units=metric';
      final weatherResponse = await http.get(Uri.parse(weatherUrl));

      if (weatherResponse.statusCode == 200) {
        final weatherData = jsonDecode(weatherResponse.body);
        final temp = weatherData['main']['temp'];
        final description = weatherData['weather'][0]['description'];

        setState(() {
          // Update the state with fetched weather data
          _currentDate = _getCurrentDate();
          _temperature = temp.toStringAsFixed(0);
          _description = description;
        });
      }
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    return 'Today, $day $month';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back button
        title: Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Handle search here
                  print('Search query: $value');
                },
              ),
            ),
            SizedBox(width: 16.0),
            Icon(Icons.kebab_dining),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.freepik.com/free-vector/sky-background-video-conferencing_23-2148639325.jpg?t=st=1712294524~exp=1712295124~hmac=19fa1dee992a433f2b51746f0a183b0df95261074e75a03066b4ce67961d905a',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentDate,
                    style: TextStyle(
                      fontSize: 16.0,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _description,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16.0,
              bottom: 16.0,
              child: Text(
                _temperature,
                style: TextStyle(
                  fontSize: 85.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle reload action
                  _fetchWeatherData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:flutter_application_weather_app/model/city.dart';
// import 'package:flutter_application_weather_app/services.dart';
// import 'package:provider/provider.dart';

// class SearchResult extends StatefulWidget {
//   final String searchTerm;

//   const SearchResult({Key? key, required this.searchTerm}) : super(key: key);

//   @override
//   _SearchResultState createState() => _SearchResultState();
// }

// class _SearchResultState extends State<SearchResult> {
//   late TextEditingController _searchController;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController(text: widget.searchTerm);
//     _fetchWeatherData();
//   }

//   Future<void> _fetchWeatherData() async {
//     final weatherData = await WeatherService.fetchWeatherData(widget.searchTerm);
//     Provider.of<SearchResultModel>(context, listen: false).updateData(
//       currentDate: weatherData['currentDate'] ?? '',
//       description: weatherData['description'] ?? '',
//       temperature: weatherData['temperature'] ?? '',
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             Icon(Icons.location_on),
//             SizedBox(width: 8.0),
//             Expanded(
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (value) {
//                   // Handle search here
//                   print('Search query: $value');
//                 },
//               ),
//             ),
//             SizedBox(width: 16.0),
//             Icon(Icons.kebab_dining),
//           ],
//         ),
//       ),
//       body: Consumer<SearchResultModel>(
//         builder: (context, model, child) {
//           return Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         'https://img.freepik.com/free-vector/sky-background-video-conferencing_23-2148639325.jpg?t=st=1712294524~exp=1712295124~hmac=19fa1dee992a433f2b51746f0a183b0df95261074e75a03066b4ce67961d905a',
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 16.0,
//                   top: 16.0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         model.currentDate,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         model.description,
//                         style: TextStyle(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 16.0,
//                   bottom: 16.0,
//                   child: Text(
//                     model.temperature,
//                     style: TextStyle(
//                       fontSize: 85.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 16.0,
//                   bottom: 16.0,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.refresh,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       // Handle reload action
//                       _fetchWeatherData();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
