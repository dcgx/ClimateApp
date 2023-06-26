import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/view/home/widgets/home_daily_forecast.dart';
import 'package:weather_app/view/home/widgets/home_hourly_forecast.dart';
import 'package:weather_app/view/home/widgets/search_text_field.dart';
import 'package:weather_app/view/shared/widgets/loading.dart';
import 'package:weather_app/view/shared/widgets/location_error.dart';
import 'package:weather_app/view/shared/widgets/request_error.dart';
import 'package:weather_app/view/home/widgets/home_current_weather.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _fetch() {
    return Provider.of<WeatherProvider>(context, listen: false).getWeather();
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF80C5F6),
                  Color(0xFF131313),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 8),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Consumer<WeatherProvider>(
              builder: (context, weatherProvider, _) {
                if (weatherProvider.isLocationError) {
                  return const LocationError(error: "No se pudo obtener la ubicación");
                }
                if (weatherProvider.isRequestError) {
                  return const RequestError(error: "Ciudad no encontrada",);
                }
                if (weatherProvider.isLoading) {
                  return const Loading();
                } else {
                  return ListView(
                    children: const [
                      SearchTextField(),
                      HomeCurrentWeather(),
                      HomeHourlyForecast(),
                      HomeDailyForecast()
                    ],
                  );
                }
              },
            )));
  }
}
