import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bee_app_training/models/weather_moderls.dart';
import 'package:flutter_bee_app_training/services/weather_service.dart';
import 'package:flutter_bee_app_training/viewmodels/forecast_view_model.dart';
import 'package:provider/provider.dart';

class WeatherViewModel extends ChangeNotifier {
  bool isRequestPending = false;
  WeatherService service = WeatherService();
  String? cityNamee;
  WeatherModel? currentWeather;
  Clouds? currentClouds;
  WeatherCondition? lastCondition;

  Future<WeatherModel> getWeather(String cityName) async {
    cityNamee = cityName;
    final response = await service.fetchWeather(cityName);
    currentWeather = response;
    currentWeather?.name = cityNamee;
    print(currentWeather);
    notifyListeners();
    return currentWeather!;
  }

  Future<WeatherModel> getLatestWeather(
      String city, BuildContext context) async {
    setRequestPendingState(true);
    WeatherModel? latest;
    try {
      await Future.delayed(Duration(seconds: 1), () => {});

      latest = await service.fetchWeather(city);
    } catch (e) {
      "this.isRequestError = true";
    }

    updateModel(latest!, city, context);
    Provider.of<ForecastViewModel>(context, listen: false).getForecast(
        latest.coord!.lat.toString(), latest.coord!.lon.toString());
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    this.isRequestPending = isPending;
    notifyListeners();
  }

  Future updateModel(
      WeatherModel forecast, String city, BuildContext context) async {
    cityNamee = city;
    final response = await service.fetchWeather(cityNamee);
    currentWeather = response;
    currentWeather?.name = cityNamee;
    print(currentWeather);

    notifyListeners();
    return currentWeather!;
  }
}
