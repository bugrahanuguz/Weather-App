import 'package:flutter/material.dart';
import 'package:flutter_bee_app_training/viewmodels/city_entry_view_model.dart';
import 'package:flutter_bee_app_training/viewmodels/forecast_view_model.dart';
import 'package:flutter_bee_app_training/viewmodels/weather_view_model.dart';
import 'package:flutter_bee_app_training/views/homepage_view.dart';
import 'package:flutter_bee_app_training/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherViewModel()),
        ChangeNotifierProvider(create: (context) => CityEntryViewModel()),
        ChangeNotifierProvider(create: (context) => ForecastViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
