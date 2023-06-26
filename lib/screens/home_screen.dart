import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/daily_forecast_list_widget.dart';
import 'package:weather_app/widgets/hourly_list_widget.dart';
import 'package:weather_app/widgets/search_city_text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  Future<void> _fetch() {
    _isLoading = true;
    return Provider.of<WeatherProvider>(context, listen: false)
        .getWeather()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refresh() {
    return Provider.of<WeatherProvider>(context, listen: false)
        .getWeather();
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
              gradient: LinearGradient(
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
                  offset: Offset(0, 8),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Consumer<WeatherProvider>(
              builder: (context, weatherProvider, _) {
                if (weatherProvider.isLocationError)
                  return Center(child: Text('Location Error'));
                if (weatherProvider.isRequestError)
                  return Center(child: Text('Request Error'));
                else {
                  return ListView(
                    children: [
                      SearchCityTextFieldWidget(),
                      CurrentWeatherWidget(),
                      HourlyListWidget(),
                      DailyForecastListWidget()
                    ],
                  );
                }
              },
            )));
  }
}
