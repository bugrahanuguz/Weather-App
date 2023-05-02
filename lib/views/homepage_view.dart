import 'package:flutter/material.dart';
import 'package:flutter_bee_app_training/components/city_location.dart';
import 'package:flutter_bee_app_training/models/weather_moderls.dart';
import 'package:flutter_bee_app_training/viewmodels/forecast_view_model.dart';
import 'package:flutter_bee_app_training/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';
import '../components/city_changed.dart';
import '../components/city_variables.dart';
import '../components/daily_weather.dart';
import '../components/icon_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  // void initState() {
  //   super.initState();
  //   onStart();
  // }

  // Future onStart() async {
  //   String cityName = "Mersin";
  //   var provider = Provider.of<WeatherViewModel>(context, listen: false);
  //   provider.getWeather(cityName);
  // }

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<WeatherViewModel>(context, listen: false).currentWeather;
    var sunrise = provider!.sys!.sunrise;
    var sunset = provider.sys!.sunset;
    DateTime currentTime = DateTime.now();
    final DateTime sunriseTime =
        DateTime.fromMillisecondsSinceEpoch(sunrise! * 1000);
    final DateTime sunsetTime =
        DateTime.fromMillisecondsSinceEpoch(sunset! * 1000);
    late Color backgroundColor;
    bool isDay = false;
    if (currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime)) {
      backgroundColor = Color.fromARGB(255, 255, 187, 0);
      isDay = true;
    } else {
      backgroundColor = Color.fromARGB(255, 15, 68, 112);
      isDay = false;
    }
    var provider2 = Provider.of<ForecastViewModel>(context, listen: false);
    provider2.getForecast(
        provider.coord!.lat.toString(), provider.coord!.lon.toString());
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CityChangedView(
                isDay: isDay,
              ),
              Provider.of<WeatherViewModel>(context).isRequestPending
                  ? buildBusyIndicator()
                  : Provider.of<WeatherViewModel>(context).isRequestPending !=
                          false
                      ? Center(
                          child: Text('Ooops...something went wrong',
                              style:
                                  TextStyle(fontSize: 21, color: Colors.white)))
                      : LocationView(
                          longitude: context
                              .watch<WeatherViewModel>()
                              .currentWeather!
                              .coord!
                              .lon,
                          latitude: context
                              .watch<WeatherViewModel>()
                              .currentWeather
                              ?.coord!
                              .lat,
                          city: context.watch<WeatherViewModel>().cityNamee),
              IconWidget(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  context
                      .watch<WeatherViewModel>()
                      .currentWeather!
                      .weather![0]
                      .description
                      .toString()
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Column(
                children: [
                  Container(
                    //alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "${(context.watch<WeatherViewModel>().currentWeather!.main!.temp!).toInt()} C°",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    "Feels Like: "
                    "${(context.watch<WeatherViewModel>().currentWeather!.main!.feelsLike!).toInt()} C°",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              _sizedBox(context),
              CityVariables(
                isDay: isDay,
              ),
              _sizedBox(context),
              DailyWeather(
                isDay: isDay,
              )

              //TempWidget(condition: context.watch<WeatherViewModel>().lastCondition!, feelsLike: context.watch<WeatherViewModel>().currentWeather!.main!.feelsLike!, isdayTime: true, temp: context.read<WeatherViewModel>().currentWeather!.main!.temp!,),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _sizedBox(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.03,
  );
}

Widget buildBusyIndicator() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
    SizedBox(
      height: 20,
    ),
    Text('Please Wait...',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ))
  ]);
}
