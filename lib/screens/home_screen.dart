import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/hourly_list_widget.dart';

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
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF80C5F6),
                  Color(0xFF131313),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, 8),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Consumer<WeatherProvider>(
              builder: (context, weatherProvider, _) {
                if (weatherProvider.isLocationError)
                  return Center(child: Text('Location Error'));
                if (weatherProvider.isRequestError)
                  return Center(child: Text('Request Error'));
                else {
                  return ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(
                              '14 °',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 130,
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
                                      fontSize: 20,
                                      color: Colors.white,
                                      height: 1.5),
                                ),
                              ),
                              Container(
                                child: SvgPicture.asset(
                                  'assets/icons/location.svg',
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Container(
                            child: Text(
                              'Mie, 10 Agosto 10:14 am',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      HourlyListWidget()
                    ],
                  );
                }
              },
            )));
  }
}
