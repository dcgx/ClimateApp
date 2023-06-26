import 'package:flutter/material.dart';

class SearchCityTextFieldWidget extends StatefulWidget {
  const SearchCityTextFieldWidget({super.key});

  @override
  State<SearchCityTextFieldWidget> createState() =>
      _SearchCityTextFieldWidgetState();
}

class _SearchCityTextFieldWidgetState extends State<SearchCityTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        style: TextStyle(color: Colors.white),
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
  }
}
