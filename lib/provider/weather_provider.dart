import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = '9b423a8c22a9141aad5651901189406c';

  bool isLoading = false;
  bool isLocationError = false;
  bool isRequestError = false;

  Weather? weather;

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

  Future<void> getWeather() {
    return Future(() => null);
  }

  Future<void> getCurrentWeather() async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=1&lon=1&units=metric&appid=$apiKey',
    );

    try {
      final response = await http.get(url);
      final jsonDecoded = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(jsonDecoded);
    } catch (error) {
      print(error);
      isLoading = false;
      this.isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
