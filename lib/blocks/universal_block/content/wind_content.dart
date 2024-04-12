import 'package:flutter/material.dart';
import 'package:flutter_compass_view/compass_view.dart';

class WindContentWidget extends StatelessWidget {
  const WindContentWidget(
      {super.key, required this.windAngle, required this.windSpeed});
  final double windAngle;
  final double windSpeed;
  @override
  Widget build(BuildContext context) {
    return CompassView(
      windAngle: windAngle,
      foregroundColor: Colors.white60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${windSpeed.round()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'м/c',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
