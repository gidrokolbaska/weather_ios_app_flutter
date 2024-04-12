import 'package:flutter/material.dart';

class PressureContentWidget extends StatelessWidget {
  const PressureContentWidget({super.key, required this.pressure});
  final int pressure;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '$pressure',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            height: 1,
          ),
        ),
        const Text(
          'мм рт. ст.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            height: 1,
          ),
        ),
      ],
    );
  }
}
