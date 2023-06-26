import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/daily_forecast_list_item_widget.dart';

class DailyForecastListWidget extends StatefulWidget {
  const DailyForecastListWidget({super.key});

  @override
  State<DailyForecastListWidget> createState() =>
      _DailyForecastListWidgetState();
}

class _DailyForecastListWidgetState extends State<DailyForecastListWidget> {
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
                      return DailyForecastListItemWidget(
                        forecast: weatherProvider.dailyForecastWeather![index],
                      );
                    }))
          ],
        );
      },
    );
  }
}
