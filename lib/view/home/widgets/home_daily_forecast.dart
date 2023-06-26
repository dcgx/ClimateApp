import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/helpers/utils.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomeDailyForecast extends StatefulWidget {
  const HomeDailyForecast({super.key});

  @override
  State<HomeDailyForecast> createState() => _HomeDailyForecastState();
}

class _HomeDailyForecastState extends State<HomeDailyForecast> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Column(
          children: [
            Container(
                height: 400,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: weatherProvider.dailyForecastWeather == null
                        ? 0
                        : weatherProvider.dailyForecastWeather!.length,
                    itemBuilder: (context, index) {
                      Forecast forecast =
                          weatherProvider.dailyForecastWeather![index];

                      return Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(forecast!.day ?? '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                    child: Mapper.mapWeatherTypeToIcon(
                                        forecast!.weatherType, 40)),
                              ),
                              SizedBox(width: 10),
                              Text(
                                  "${forecast!.tempMax.toStringAsFixed(1)}° / ${forecast!.tempMin.toStringAsFixed(1)}°",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal)),
                            ]),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(247, 112, 207, 220),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5))
                            ]),
                      );
                    }))
          ],
        );
      },
    );
  }
}
