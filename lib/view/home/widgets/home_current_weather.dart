import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomeCurrentWeather extends StatefulWidget {
  const HomeCurrentWeather({super.key});

  @override
  State<HomeCurrentWeather> createState() => _HomeCurrentWeatherState();
}

class _HomeCurrentWeatherState extends State<HomeCurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                // Text(
                //   '°C',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.w700,
                //     fontSize: 10,
                //   ),
                // ),
                Text(
                  '${weatherProvider.currentWeather?.temp.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 130,
                  ),
                ),
                  ],
                ),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weatherProvider.currentWeather?.cityName ?? '-',
                        style: const TextStyle(
                            fontSize: 20, color: Colors.white, height: 1.5),
                      ),
                      SvgPicture.asset(
                        'assets/icons/location.svg',
                        color: Colors.white,
                      )
                    ],
                  ),
                  Text(
                    weatherProvider.currentWeather?.description ?? '-',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateFormat.yMMMEd().add_jm().format(DateTime.now()),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                    ),
                  ),
                ]),
              ],
            )
          ],
        );
      },
    );
  }
}
