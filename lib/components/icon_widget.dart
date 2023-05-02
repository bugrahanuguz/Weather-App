import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bee_app_training/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String? iconName = context
        .read<WeatherViewModel>()
        .currentWeather!
        .weather![0]
        .icon
        .toString();
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Image.asset(
          "assets/weather/icon_$iconName.png",
          fit: BoxFit.cover,
        ));
  }
}
