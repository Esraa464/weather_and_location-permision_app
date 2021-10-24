import 'package:dio/dio.dart';
import 'package:weather_and_location/screens/current_weather_page/model.dart';

class SearchController {
  Dio dio = Dio();

  Future<WeatherInfo> fetchData(city) async {
    try {
      final response = await dio.get(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=9c15af06166e304ab03ac7075db2b74a');
      final resp = response.data;
      print(resp);
      return response.statusCode == 200 ? WeatherInfo.fromJson(resp) : null;
    } catch (_) {
      return null;
    }
  }
}
