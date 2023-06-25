import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = 'YOUR_API_KEY';
  bool isLoading = false;
  bool isLocationError = false;
  bool isRequestError = false;

  bool checkIsLoading() {
    return false;
  }

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

  Future<void> getCurrentWeather() {
    return Future(() => null);
  }
}
