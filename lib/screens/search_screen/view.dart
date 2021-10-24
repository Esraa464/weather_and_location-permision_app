import 'package:flutter/material.dart';
import 'package:weather_and_location/screens/current_weather_page/model.dart';

import 'controller.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controller = TextEditingController();
  WeatherInfo _weatherInfo;
  bool isLoading = false;

  data(city) async {
    _weatherInfo = await SearchController().fetchData(city);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           onPrimary: Colors.deepOrange,
            //           primary: Colors.amber,
            //           padding: EdgeInsets.all(20)),
            //       onPressed: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => MyMap()));
            //       },
            //       child: Text('open on map')),
            // ),
            TextFormField(
              onFieldSubmitted: (v) {
                data(v);
              },
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Choose City',
              ),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: _weatherInfo == null
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text('No Result!'),
                            ),
                          ]
                        : [
                            Text('city name:  ${_weatherInfo.name}',
                                style: TextStyle(fontSize: 20)),
                            Text("temp:${_weatherInfo.main.temp}".toString(),
                                style: TextStyle(fontSize: 20)),
                            Text(
                                "weather:${_weatherInfo.weather[0].description}",
                                style: TextStyle(fontSize: 20)),
                            Text("country Name:${_weatherInfo.sys.country}",
                                style: TextStyle(fontSize: 20)),
                          ],
                  ),
          ],
        ),
      ),
    );
  }
}
