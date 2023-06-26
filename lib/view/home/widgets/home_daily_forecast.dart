import 'package:flutter/material.dart';
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
            SizedBox(
                height: 400,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: weatherProvider.dailyForecastWeather == null
                        ? 0
                        : weatherProvider.dailyForecastWeather!.length,
                    itemBuilder: (context, index) {
                      Forecast forecast =
                          weatherProvider.dailyForecastWeather![index];

                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                List<Forecast> forecastList = weatherProvider
                                    .getHourlyForecastByDay(weatherProvider
                                        .dailyForecastWeather![index].day);

                                return SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: ListView.builder(
                                        itemCount: forecastList.length,
                                        itemBuilder: (context, fIndex) {
                                          return ListTile(
                                              title: Text(forecastList[fIndex].hour),
                                              subtitleTextStyle:
                                                  const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              subtitle: Align(
                                                alignment: Alignment.topLeft,
                                                child:
                                                    Mapper.mapWeatherTypeToIcon(
                                                        forecastList[fIndex]
                                                            .weatherType,
                                                        22,
                                                        Colors.black),
                                              ),
                                              trailing: Text(
                                                  "${forecastList[fIndex].tempMin.toStringAsFixed(1)}° / ${forecastList[fIndex].tempMax.toStringAsFixed(1)}°"));
                                        }));
                              });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
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
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(forecast.day,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                      child: Mapper.mapWeatherTypeToIcon(
                                          forecast.weatherType,
                                          40,
                                          Colors.white)),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                    "${forecast.tempMax.toStringAsFixed(1)}° / ${forecast.tempMin.toStringAsFixed(1)}°",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                              ]),
                        ),
                      );
                    }))
          ],
        );
      },
    );
  }
}
