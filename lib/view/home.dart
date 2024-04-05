import 'package:flutter/material.dart';

import 'package:flutter_application_weather_app/view/search.dart';





class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the search page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
          child: const Text('Go to Search Page'),
        ),
      ),
    );
  }
}


