import 'package:flutter/material.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class UviProgressBarWidget extends StatelessWidget {
  UviProgressBarWidget({super.key, required this.uviIndex});
  final double uviIndex;
  final LinearGradient gradient = LinearGradient(colors: [
    Colors.green.shade600,
    Colors.yellow.shade600,
    Colors.red.shade600,
    Colors.purpleAccent,
  ]);
  double normalizedUviIndexValue(double v) {
    return 1 / 11 * v;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      value: normalizedUviIndexValue(uviIndex),
      color: Colors.white,
      gradient: gradient,
      width: double.maxFinite,
      height: 5,
      thumbRadius: 2.5,
    );
  }
}
