import 'package:flutter/material.dart';
import 'package:flutter_bee_app_training/viewmodels/forecast_view_model.dart';
import 'package:flutter_bee_app_training/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

class CityEntryViewModel with ChangeNotifier {
  late String _city;

  CityEntryViewModel();

  String get city => _city;

  void refreshWeather(String newCity, BuildContext context) {
    Provider.of<WeatherViewModel>(context, listen: false)
        .getLatestWeather(_city, context);
    context.read<ForecastViewModel>().getForecast(
        context.read<WeatherViewModel>().currentWeather!.coord!.lat.toString(),
        context.read<WeatherViewModel>().currentWeather!.coord!.lon.toString());
    notifyListeners();
  }

  void updateCity(String newCity) {
    _city = newCity;
  }
}
