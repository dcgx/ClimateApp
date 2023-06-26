import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/hourly_detail_widget.dart';

class HourlyListWidget extends StatefulWidget {
  const HourlyListWidget({super.key});

  @override
  State<HourlyListWidget> createState() => _HourlyListWidgetState();
}

class _HourlyListWidgetState extends State<HourlyListWidget> {
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
                  color: Color.fromARGB(247, 112, 207, 220),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherProvider.hourlyForecastWeather == null
                    ? 0
                    : weatherProvider.hourlyForecastWeather!.length,
                itemBuilder: (context, index) {
                  return HourlyDetailWidget(
                      forecast:
                          weatherProvider.hourlyForecastWeather![index]);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
