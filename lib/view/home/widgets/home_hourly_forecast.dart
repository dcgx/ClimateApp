import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/helpers/utils.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomeHourlyForecast extends StatefulWidget {
  const HomeHourlyForecast({super.key});

  @override
  State<HomeHourlyForecast> createState() => _HomeHourlyForecastState();
}

class _HomeHourlyForecastState extends State<HomeHourlyForecast> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Column(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(247, 112, 207, 220),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ]),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherProvider.hourlyForecastWeather == null
                    ? 0
                    : weatherProvider.hourlyForecastWeather!.length,
                itemBuilder: (context, index) {
                  Forecast forecast =
                      weatherProvider.hourlyForecastWeather![index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              forecast.hour,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                                child: Mapper.mapWeatherTypeToIcon(
                                    forecast.weatherType, 20)),
                          ],
                        ),
                        Column(
                          children: [
                            Text(forecast.temp.toStringAsFixed(1) + '°',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal)),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
