import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DailyForecastListItemWidget extends StatefulWidget {
  const DailyForecastListItemWidget({super.key});

  @override
  State<DailyForecastListItemWidget> createState() =>
      _DailyForecastListItemWidgetState();
}

class _DailyForecastListItemWidgetState
    extends State<DailyForecastListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Monday',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Container(
              child: SvgPicture.asset(
                'assets/icons/sun.svg',
                height: 35,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Text('60%',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w200)),
            Text('18° / 14°',
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
  }
}
