import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/helpers/utils.dart';

import '../models/forecast.dart';

class HourlyDetailWidget extends StatefulWidget {
  final Forecast? forecast;

  const HourlyDetailWidget({super.key, this.forecast});

  @override
  State<HourlyDetailWidget> createState() => _HourlyDetailWidgetState();
}

class _HourlyDetailWidgetState extends State<HourlyDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                this.widget.forecast!.hour,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Container(
                  child: Mapper.mapWeatherTypeToIcon(
                      this.widget.forecast!.weatherType, 20)),
            ],
          ),
          Column(
            children: [
              Text(this.widget.forecast!.temp.toStringAsFixed(1) + '°',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
            ],
          )
        ],
      ),
    );
  }
}
