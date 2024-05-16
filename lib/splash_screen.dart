import 'package:flutter/material.dart';
import 'package:wheather/city_selection.dart';
import 'package:wheather/weather_screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Splash_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateHome();
  }

  navigateHome()async{
    await Future.delayed(Duration(milliseconds: 3500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => City_Selection()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(Icons.cloud,size: 80,),
        Text("Welcome To The Wheather App")
      ],)
      ),
    );
  }
}