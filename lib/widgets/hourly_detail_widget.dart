import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HourlyDetailWidget extends StatefulWidget {
  const HourlyDetailWidget({super.key});

  @override
  State<HourlyDetailWidget> createState() => _HourlyDetailWidgetState();
}

class _HourlyDetailWidgetState extends State<HourlyDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                '10 am',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Container(
                child: SvgPicture.asset(
                  'assets/icons/sun.svg',
                  height: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                '70 %',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
              ),
            ],
          ),
          Column(
            children: [
              Text('14°',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
            ],
          )
        ],
      ),
    );
  }
}
