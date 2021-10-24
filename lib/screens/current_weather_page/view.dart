import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_and_location/screens/current_weather_page/model.dart';
import 'package:weather_and_location/screens/current_weather_page/controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_and_location/screens/map/view.dart';
import 'package:weather_and_location/screens/search_screen/view.dart';

class WeatherPage extends StatefulWidget {
 final Position position;

  WeatherPage(this.position);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherInfo weatherInfo;
  bool isLoading = true;

  void data() async {
    weatherInfo = await LocationController().fetchData(
        '${widget.position.latitude}', '${widget.position.longitude}');
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
          child: ListView(
            children: [
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container( 
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(color: Colors.amberAccent,borderRadius: BorderRadius.circular(10) ),
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                      '${weatherInfo.name}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '${weatherInfo.weather[0].description}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '${weatherInfo.main.temp}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'late:${weatherInfo.coord.lat}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'lon:${weatherInfo.coord.lon}',
                      style: TextStyle(fontSize: 20),
                    ),
                ],
              ),
                  ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.deepOrange,
                        primary: Colors.amber,
                        padding: EdgeInsets.all(20)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              MyMap(lat: widget.position.latitude,log: widget.position.longitude, )));
                    },
                    //position: widget.position,
                    child: Text('open on map')),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.deepOrange,
                        primary: Colors.amber,
                        padding: EdgeInsets.all(20)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                             Search()));
                    },

                    child: Text('Search about city')),
              ),

            ],
          ),
        )



    );
  }
}
