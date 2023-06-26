import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Forecast extends ChangeNotifier {
  final dynamic temp;
  final dynamic tempMax;
  final dynamic tempMin;
  final String day;
  final String hour;
  final DateTime? datetime;
  final String weatherType;

  Forecast({
    this.temp,
    this.tempMax,
    this.tempMin,
    this.day = "",
    this.hour = "",
    this.datetime,
    this.weatherType = "",
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    String day = DateFormat('EEEE').format(dateTime);
    String hour = DateFormat('hh a').format(dateTime);

    return Forecast(
      temp: json['main']['temp'],
      tempMax: json['main']['temp_max'],
      tempMin: json['main']['temp_min'],
      weatherType: json['weather'][0]['main'],
      day: day,
      hour: hour,
      datetime: dateTime,
    );
  }

  @override
  toString() {
    return "temp: $temp, tempMax: $tempMax, tempMin: $tempMin, day: $day, hour: $hour, datetime: $datetime";
  }
}
