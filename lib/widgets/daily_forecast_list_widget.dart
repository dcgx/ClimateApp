import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Column(
      children: [
        Container(
          height: 400,
          child: ListView(scrollDirection: Axis.vertical, children: [
            DailyForecastListItemWidget(),
            DailyForecastListItemWidget(),
            DailyForecastListItemWidget(),
            DailyForecastListItemWidget(),
            DailyForecastListItemWidget(),
            DailyForecastListItemWidget(),
          ]),
        )
      ],
    );
  }
}
