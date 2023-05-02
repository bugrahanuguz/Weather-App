import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/city_entry_view_model.dart';

class CityChangedView extends StatefulWidget {
  final bool isDay;
  const CityChangedView({super.key, required this.isDay});

  @override
  State<CityChangedView> createState() => _CityChangedViewState();
}

class _CityChangedViewState extends State<CityChangedView> {
  late TextEditingController cityEditController;

  @override
  void initState() {
    super.initState();
    cityEditController = new TextEditingController();
    cityEditController.addListener(() {
      Provider.of<CityEntryViewModel>(this.context, listen: false)
          .updateCity(cityEditController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityEntryViewModel>(
        builder: (context, model, child) => Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
            padding: EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: widget.isDay == true
                  ? Colors.orangeAccent.shade100
                  : Colors.blue.shade800,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () {
                    model.updateCity(cityEditController.text);
                    model.refreshWeather(cityEditController.text, context);
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        controller: cityEditController,
                        decoration:
                            InputDecoration.collapsed(hintText: "Enter City"),
                        onSubmitted: (String city) =>
                            {model.refreshWeather(city, context)})),
              ],
            )));
  }
}
