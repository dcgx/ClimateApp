import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  Future<void> _getData() {
    _isLoading = true;

    return Future.delayed(Duration(seconds: 3), () {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Consumer<WeatherProvider>(
      builder: (context, weatherProvider, _) {
        if (weatherProvider.isLocationError)
          return Center(child: Text('Location Error'));
        if (weatherProvider.isRequestError)
          return Center(child: Text('Request Error'));
        return Container(
          decoration: BoxDecoration(color: Colors.red),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    child: Text(
                      '14 °',
                      style: TextStyle(
                        fontSize: 120,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Santiago',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.5),
                        ),
                      ),
                      Container(
                        child: SvgPicture.asset('assets/icons/location_on.svg'),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    )));
  }
}
