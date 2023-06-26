import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class SearchCityTextFieldWidget extends StatefulWidget {
  const SearchCityTextFieldWidget({super.key});

  @override
  State<SearchCityTextFieldWidget> createState() =>
      _SearchCityTextFieldWidgetState();
}

class _SearchCityTextFieldWidgetState extends State<SearchCityTextFieldWidget> {
  final _textController = new TextEditingController();
  bool _isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: _textController,
            enabled: !weatherProvider.isLoading,
            style: TextStyle(color: Colors.white),
            onSubmitted: (query) => {
              setState(() {
                if (_textController.text.isEmpty) {
                  _isValidated = true;
                } else {
                  print('search');
                  weatherProvider.searchWeather(query);
                }
                FocusScope.of(context).unfocus();
              })
            },
            decoration: InputDecoration(
              prefix: Icon(Icons.search, color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Buscar ciudad'.toUpperCase(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
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
