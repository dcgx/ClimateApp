import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/view/home/home_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WeatherProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WeatherAPP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            textTheme: GoogleFonts.abelTextTheme(Theme.of(context).textTheme)),
        home: const HomeScreen(),
        routes: const {
          // HomeScreen.routeName: (ctx) => const HomeScreen(),
          // DetailScreen.routeName: (ctx) => const DetailScreen(),
        });
  }
}
