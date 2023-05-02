import 'package:flutter/material.dart';
import 'package:flutter_bee_app_training/models/forecast_model.dart';
import 'package:flutter_bee_app_training/services/forecast_service.dart';

class ForecastViewModel extends ChangeNotifier {
  ForecastService service = ForecastService();
  Forecast? forecast;
  List<WeatherList>? forecastList = [];
  ForecastViewModel();

  Future getForecast(String lat, String lon) async {
    final response = await service.fetchForecast(lat, lon);
    forecast = response;
    //forecast2!.add(forecast!.list!.contains("15:00:00"));
    forecastList = [];
    for (var i in forecast!.list!) {
      if (i.dtTxt!.contains("15:00:00")) {
        forecastList!.add(i);
      }
    }
    print(forecastList!.length);
    notifyListeners();
    return forecastList!;
  }
}
