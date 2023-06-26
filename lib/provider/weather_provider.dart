import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:weather_app/models/daily_forecast_weather.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = '9b423a8c22a9141aad5651901189406c';

  bool isLoading = false;
  bool isRefresh = false;
  bool isLocationError = false;
  bool isRequestError = false;

  LatLng? currentLocation;

  Weather? currentWeather;
  List<Forecast>? dailyForecastWeather;
  List<Forecast>? hourlyForecastWeather;

  Future<Position> getLocation() async {
    bool isLocationServiceEnabled;
    LocationPermission locationPermission;

    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeather() async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    if (isRefresh) notifyListeners();

    Position? locData = await getLocation();
    if (locData == null) {
      isLocationError = true;
      notifyListeners();
      return;
    }

    try {
      currentLocation = LatLng(locData.latitude, locData.longitude);
      await getWeatherByLocation(currentLocation!);
      await getForecastByLocation(currentLocation!);
    } catch (e) {
      print(e);
      isLocationError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return Future(() => null);
  }

  Future<void> getWeatherByLocation(LatLng location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&lang=es&appid=$apiKey',
    );
    print(url);

    try {
      final response = await http.get(url);
      final jsonDecoded = json.decode(response.body) as Map<String, dynamic>;
      print(jsonDecoded);
      currentWeather = Weather.fromJson(jsonDecoded);
    } catch (error) {
      print(error);
      isLoading = false;
      this.isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getForecastByLocation(LatLng location) async {
    DateTime today = DateTime.now();

    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&units=metric&lang=es&appid=$apiKey',
    );
    print(url);

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;

      print(data['list']);
      hourlyForecastWeather = _getHourlyForecastWeather(data['list']);
      dailyForecastWeather = _getDailyForecastWeather(data['list']);

      print('dailyForecastWeather');
      print(dailyForecastWeather);
    } catch (error) {
      print(error);
      this.isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Forecast> _getHourlyForecastWeather(List<dynamic> list) {
    DateTime today = DateTime.now();

    return list.where((item) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      return dateTime.day == today.day;
    }).map((item) {
      Forecast forecast = Forecast.fromJson(item);
      return forecast;
    }).toList();
  }

  List<Forecast> _getDailyForecastWeather(List<dynamic> list) {
    List<Forecast>? dailyForecast = [];

    list.forEach((item) {
      Forecast forecast = Forecast.fromJson(item);

      if (dailyForecast.where((item) => item.day == forecast.day).isEmpty) {
        dailyForecast.add(forecast);
      }
    });

    return dailyForecast;
  }
}
