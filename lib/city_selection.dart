import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wheather/weather_screen.dart';

class City_Selection extends StatefulWidget {
  const City_Selection({Key? key}) : super(key: key);

  @override
  State<City_Selection> createState() => _City_SelectionState();
}

class _City_SelectionState extends State<City_Selection> {
  late TextEditingController cityController;
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
    countryController = TextEditingController();
    // fetchData();
  }

  @override
  void dispose() {
    cityController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome To The Weather App", textAlign: TextAlign.center),
        centerTitle: true,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: countryController,
              decoration: const InputDecoration(
                labelText: 'Enter country name',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 97, 91, 91),
                  minimumSize: Size(25, 60)
                  
                ),
              onPressed: () {
                
                String cityName = cityController.text;
                String countryName = countryController.text;
                // You can use cityName as needed, such as passing it to another function or API call.
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => WeatherScreen(cityName:cityName,countryName:countryName),
                  ),
                  );
              },
              child: const Text('Get Weather Data',style: TextStyle(color: Colors.white),),
              
            ),
            const SizedBox(height: 20),
            // Other widgets...
          ],
        ),
      ),
    );
  }
}