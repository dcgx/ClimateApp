import 'package:flutter/material.dart';

class DailyForecastWeather extends ChangeNotifier {
  final dynamic dailyTemp;
  final String? condition;
  final DateTime? date;
  final String? precip;
  final int? uvi;

  DailyForecastWeather({
    this.dailyTemp,
    this.condition,
    this.date,
    this.precip,
    this.uvi,
  });

  factory DailyForecastWeather.fromJson(Map<String, dynamic> json) {
    print("daily_weather");
    print(json);
    // final precipData = json['daily'][0]['pop'];
    // final calcPrecip = precipData * 100;
    // final precipitation = calcPrecip.toStringAsFixed(0);
    return DailyForecastWeather(
      precip: '',
    );
  }
}
