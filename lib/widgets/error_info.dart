import 'package:flutter/material.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: Text(
            'Ciudad no encontrada',
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }
}
