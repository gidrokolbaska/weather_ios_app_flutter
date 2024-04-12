import 'package:flutter/material.dart';

class FeelsLikeWidget extends StatelessWidget {
  const FeelsLikeWidget({super.key, required this.tempFeelsLike});
  final double tempFeelsLike;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${tempFeelsLike.round()}°',
        style: const TextStyle(color: Colors.white, fontSize: 70, height: 1),
      ),
    );
  }
}
