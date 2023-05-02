import 'package:flutter/material.dart';
import 'package:flutter_bee_app_training/viewmodels/forecast_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/forecast_model.dart';

class DailyWeather extends StatelessWidget {
  final bool isDay;
  const DailyWeather({super.key, required this.isDay});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    List<WeatherList>? forecastList =
        context.watch<ForecastViewModel>().forecastList;
    return Container(
      decoration: BoxDecoration(
        color:
            isDay == true ? Colors.orangeAccent.shade100 : Colors.blue.shade800,
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.height * 0.1,
      child: forecastList!.length == null ? SizedBox(): ListView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: forecastList.length,
          itemBuilder: (BuildContext context, index) {
            String? iconName = forecastList[index].weather![0].icon;
            return Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayName(forecastList[index].dt),
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                    Text(
                      forecastList[index].main!.temp!.toInt().toString() +
                          " C°",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/weather/icon_$iconName.png",
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            );
          }),
    );
  }
}

dayName(num? epoch) {
  DateTime sunsetTime =
      DateTime.fromMillisecondsSinceEpoch(epoch!.toInt() * 1000);
  return DateFormat('EE').format(sunsetTime);
}
