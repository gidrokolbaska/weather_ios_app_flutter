import 'package:flutter/material.dart';

class RainContentWidget extends StatelessWidget {
  const RainContentWidget({super.key, required this.rain});
  final double rain;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${rain.round()} мм',
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.white, fontSize: 35, height: 1),
        ),
        const Text(
          'за последние\n24 ч',
          style: TextStyle(color: Colors.white, fontSize: 25, height: 1),
        )
      ],
    );
  }
}
