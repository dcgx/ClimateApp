import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = '9b423a8c22a9141aad5651901189406c';

  bool isLoading = false;
  bool isRefresh = false;
  bool isLocationError = false;
  bool isRequestError = false;
  bool isNotFound = false;

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
    // ignore: unnecessary_null_comparison
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
      Response response = await http.get(url);
      final jsonDecoded = json.decode(response.body) as Map<String, dynamic>;
      currentWeather = Weather.fromJson(jsonDecoded);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      isLoading = false;
      isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchWeather(String query) async {
    isLoading = true;
    notifyListeners();
    isRequestError = false;
    isLocationError = false;

    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$query&units=metric&appid=$apiKey',
    );

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      currentWeather = Weather.fromJson(extractedData);
      if (currentWeather == null) {
        isNotFound = true;
        return;
      } else {
        await getForecastByLocation(LatLng(
            currentWeather!.lat.toDouble(), currentWeather!.long.toDouble()));
      }
    } catch (error) {
      print(error);
      isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getForecastByLocation(LatLng location) async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&units=metric&lang=es&appid=$apiKey',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      hourlyForecastWeather = _getHourlyForecastWeather(data['list']);
      dailyForecastWeather = _getDailyForecastWeather(data['list']);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      isRequestError = true;
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

    for (var item in list) {
      Forecast forecast = Forecast.fromJson(item);

      if (dailyForecast.where((item) => item.day == forecast.day).isEmpty) {
        dailyForecast.add(forecast);
      }
    }

    return dailyForecast;
  }
}
