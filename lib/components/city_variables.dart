import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../viewmodels/weather_view_model.dart';

class CityVariables extends StatelessWidget {
  final bool isDay;
  const CityVariables({super.key, required this.isDay});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
          color: isDay == true
              ? Colors.orangeAccent.shade100
              : Colors.blue.shade800,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.water_drop,
                color: textColor,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              Text(
                context
                        .watch<WeatherViewModel>()
                        .currentWeather!
                        .main!
                        .humidity
                        .toString() +
                    " %",
                style: TextStyle(color: textColor),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.wind_power,
                color: textColor,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              Text(
                  (context
                                  .watch<WeatherViewModel>()
                                  .currentWeather!
                                  .wind!
                                  .speed! *
                              3.6)
                          .toInt()
                          .toString() +
                      " km/h",
                  style: TextStyle(color: textColor)),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.cloud,
                color: textColor,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              Text(
                  (context
                              .watch<WeatherViewModel>()
                              .currentWeather!
                              .clouds!
                              .all)
                          .toString() +
                      " %",
                  style: TextStyle(color: textColor))
            ],
          ),
        ],
      ),
    );
  }
}
