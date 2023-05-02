import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bee_app_training/viewmodels/forecast_view_model.dart';
import 'package:flutter_bee_app_training/viewmodels/weather_view_model.dart';
import 'package:flutter_bee_app_training/views/homepage_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onStart();
  }

  Future onStart() async {
    String cityName = "Mersin";
    var provider = Provider.of<WeatherViewModel>(context, listen: false);
    await provider.getWeather(cityName);
    Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/background/splash-screen.json',
          fit: BoxFit.fill),
      splashIconSize: 1000,
      nextScreen: HomePage(),
      duration: 2000,
      animationDuration: Duration(seconds: 2),
    );
  }
}
