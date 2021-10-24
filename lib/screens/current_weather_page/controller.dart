import 'package:dio/dio.dart';
import 'package:weather_and_location/screens/current_weather_page/model.dart';

class LocationController {
  // Dio dio = Dio();
  Future<WeatherInfo> fetchData(String lat, String long) async {
    final response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=9c15af06166e304ab03ac7075db2b74a');
    // final resp = response.data;
    print(response.data);
    return WeatherInfo.fromJson(response.data);
  }
}
