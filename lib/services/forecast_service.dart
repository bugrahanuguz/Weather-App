import 'dart:convert';

import 'package:flutter_bee_app_training/models/forecast_model.dart';
import 'package:http/http.dart' as http;

class ForecastService {
  String key = "";
  String name = "Istanbul";
  String baseApi = "https://api.openweathermap.org/data/2.5/forecast";
  Uri getUrl(String lat, String lon) =>
      Uri.parse("$baseApi?lat=$lat&lon=$lon&appid=$key&units=metric");

  Future fetchForecast(String latt, String lonn) async {
    print(getUrl(latt, lonn));
    http.Response response = await http.get(getUrl(latt, lonn));
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      Forecast weather = Forecast.fromJson(data);
      return weather;
    }
  }
}
