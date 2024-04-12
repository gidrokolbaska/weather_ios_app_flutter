import 'package:flutter/material.dart';

class VisibilityWidget extends StatelessWidget {
  const VisibilityWidget({super.key, required this.visibility});
  final int visibility;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Center(
        child: Text(
          '${(visibility / 1000).round()} км',
          style: const TextStyle(color: Colors.white, fontSize: 70, height: 1),
        ),
      ),
    );
  }
}
