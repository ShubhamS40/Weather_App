
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  // const WeatherScreen({super.key});
    
    final String cityName;
    final String countryName;
      WeatherScreen({required this.cityName, required this.countryName, Key? key}) : super(key: key);


  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
    String town = 'Delhi';
  late Future<Map<String, dynamic>> weath;
  
  late String temperature;
  late String windspeed;
  late String humidity;
  late String feelslike;

 @override
  void initState() {
    super.initState();
    fetchData(widget.cityName,widget.countryName);
    weath = fetchData(widget.cityName,widget.countryName);
  }

  Future<Map<String, dynamic>> fetchData(String cityName,String countryName) async {
    final url = 'https://weather-by-api-ninjas.p.rapidapi.com/v1/weather?city=$cityName';
    final headers = {
      'X-RapidAPI-Key': '214c442645msh072a29c9372a4c7p191ff3jsn8f51e0955617',
      'X-RapidAPI-Host': 'weather-by-api-ninjas.p.rapidapi.com'
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final weather = json.decode(response.body);
      print(response.body);
      setState(() {
        temperature = weather['temp'].toString();
        humidity = weather['humidity'].toString();
        windspeed = weather['wind_speed'].toString();
        feelslike = weather['feels_like'].toString();
      });
      return weather;
    } else {
      print('Failed to load data');
      throw Exception('Failed to load data');
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Weather App ${widget.countryName}/${widget.cityName}", textAlign: TextAlign.center),
        centerTitle: true,
        actions: [IconButton(onPressed: () {
          setState(() {
            weath = fetchData(widget.countryName,widget.cityName);
          });
        }, icon: Icon(Icons.refresh))],
      ),
      body: FutureBuilder(
        
        future: weath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  // Weather Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 145),
                      child: Column(
                        children: [
                          Text(
                            "$temperature °C",
                            style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(height: 10),
                          Icon(
                            Icons.sunny,
                            size: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Clear",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Card Weather Forecast
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Weather Forecast",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: Column(
                              children: [
                                Text("03:00"),
                                Icon(Icons.sunny),
                                Text("320.12"),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: Column(
                              children: [
                                Text("04:00"),
                                Icon(Icons.cloud),
                                Text("320.12"),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: Column(
                              children: [
                                Text("05:00"),
                                Icon(Icons.cloud),
                                Text("320.12"),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: Column(
                              children: [
                                Text("06:00"),
                                Icon(Icons.sunny_snowing),
                                Text("320.12"),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: Column(
                              children: [
                                Text("07:00"),
                                Icon(Icons.nightlight),
                                Text("320.12"),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: Column(
                              children: [
                                Text("08:00"),
                                Icon(Icons.nightlight),
                                Text("320.12"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Additional information", style: TextStyle(
                          fontSize: 19
                        ),)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.water_drop),
                            Text("Humidity"),
                            Text("$humidity%"),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.air),
                            Text("Wind Speed"),
                            Text("$windspeed km/hr"),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.beach_access),
                            Text("Feels Like"),
                            Text("$feelslike °C")
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
          return Container();
        }
      ),
    );
  }
}
