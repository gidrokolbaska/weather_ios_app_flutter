import 'package:flutter/material.dart';

class HumidityWidget extends StatelessWidget {
  const HumidityWidget(
      {super.key, required this.humidity, required this.dewPoint});
  final double humidity;
  final double dewPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '${humidity.round()} %',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 35,
          ),
        ),
        Text(
          'Точка росы\nсейчас ${dewPoint.round()}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            height: 1,
          ),
        )
      ],
    );
  }
}
