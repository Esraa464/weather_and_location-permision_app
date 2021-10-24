import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_and_location/screens/current_weather_page/controller.dart';
import 'package:weather_and_location/screens/current_weather_page/model.dart';

class MyMap extends StatefulWidget {
  final lat;
  final log;

  // final position;

  const MyMap({
    Key key,
    @required this.lat,
    @required this.log,
    // @required this.position
  }) : super(key: key);

  @override
  _MyMappState createState() => _MyMappState();
}

class _MyMappState extends State<MyMap> {
  List<Marker> markers = [];
  WeatherInfo weatherInfo;

  onTapped(LatLng point) async {
    setState(() {
      markers = [];
      markers
          .add(Marker(markerId: MarkerId(point.toString()), position: point));
      print(point.toString());
      print(point.latitude);
      print(point.longitude);
    });

    LocationController locationController = LocationController();
    weatherInfo = await locationController.fetchData(
        point.latitude.toString(), point.longitude.toString());

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: Column(
          children: weatherInfo == null
              ? [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('No Result!'),
                  ),
                ]
              : [
                  Text('city name:  ${weatherInfo.name}',
                      style: TextStyle(fontSize: 20)),
                  Text("temp:${weatherInfo.main.temp}".toString(),
                      style: TextStyle(fontSize: 20)),
                  Text("weather:${weatherInfo.weather[0].description}",
                      style: TextStyle(fontSize: 20)),
                  Text("country Name:${weatherInfo.sys.country}",
                      style: TextStyle(fontSize: 20)),
                ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          onTap: onTapped,
          onMapCreated: (_) {
            setState(() {
              markers.add(Marker(
                markerId: MarkerId('id-1'),
                position: LatLng(widget.lat, widget.log),
              ));
            });
          },
          markers: Set.from(markers),
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.log),
            zoom: 12.0,
          )),
    );
  }
}
