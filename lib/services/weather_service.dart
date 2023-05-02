import 'dart:convert';
import 'package:flutter_bee_app_training/models/weather_moderls.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  String key = "";
  String name = "Istanbul";
  String baseApi = "https://api.openweathermap.org/data/2.5/weather?q=";
  Uri getUrl(String cityName) =>
      Uri.parse("$baseApi$cityName&appid=$key&units=metric&lang=tr");

  Future fetchWeather(cityName) async {
    cityName ?? (cityName = name);
    http.Response response = await http.get(getUrl(cityName));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);
      print(weather);
      return weather;
    }
  }
}
