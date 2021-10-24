import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_and_location/screens/current_weather_page/view.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Position currentPosition;

  currentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    currentLocation();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WeatherPage(currentPosition))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
        'https://www.educationquizzes.com/library/KS2-Geography/Weather/Weather-5.jpg',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
