import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() =>
      _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: _textController,
            enabled: !weatherProvider.isLoading,
            style: const TextStyle(color: Colors.white),
            onSubmitted: (query) => {
              setState(() {
                if (_textController.text.isEmpty) {
                } else {
                  weatherProvider.searchWeather(query);
                }
                FocusScope.of(context).unfocus();
              })
            },
            decoration: InputDecoration(
              prefix: const Icon(Icons.search, color: Colors.white),
              hintStyle: const TextStyle(color: Colors.white),
              hintText: 'Buscar ciudad'.toUpperCase(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
