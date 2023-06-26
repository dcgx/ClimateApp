import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/helpers/utils.dart';
import 'package:weather_app/models/forecast.dart';

class DailyForecastListItemWidget extends StatefulWidget {
  final Forecast? forecast;
  const DailyForecastListItemWidget({super.key, this.forecast});

  @override
  State<DailyForecastListItemWidget> createState() =>
      _DailyForecastListItemWidgetState();
}

class _DailyForecastListItemWidgetState
    extends State<DailyForecastListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(this.widget.forecast!.day ?? '-',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                  child: Mapper.mapWeatherTypeToIcon(
                      this.widget.forecast!.weatherType, 40)),
            ),
            SizedBox(width: 10),
            Text(
                "${this.widget.forecast!.tempMax.toStringAsFixed(1)}° / ${this.widget.forecast!.tempMin.toStringAsFixed(1)}°",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal)),
          ]),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color.fromARGB(247, 112, 207, 220),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]),
    );
  }
}
