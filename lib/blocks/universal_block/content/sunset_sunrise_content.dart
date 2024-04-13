import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SunsetSunriseWidget extends StatelessWidget {
  const SunsetSunriseWidget(
      {super.key, required this.sunrise, required this.sunset});
  final DateTime sunrise;
  final DateTime sunset;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              CupertinoIcons.sunrise_fill,
              color: Colors.white,
              size: 40,
            ),
            Text(
              DateFormat('HH:mm').format(sunrise
                  .add(Duration(hours: DateTime.now().timeZoneOffset.inHours))),
              style: const TextStyle(color: Colors.white, fontSize: 35),
            )
          ],
        ),
        const Divider(
          height: 1,
          indent: 8,
          endIndent: 8,
          color: Colors.white30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              CupertinoIcons.sunset_fill,
              color: Colors.white,
              size: 40,
            ),
            Text(
              DateFormat('HH:mm').format(sunset
                  .toLocal()
                  .add(Duration(hours: DateTime.now().timeZoneOffset.inHours))),
              style: const TextStyle(color: Colors.white, fontSize: 35),
            )
          ],
        )
      ],
    );
  }
}
