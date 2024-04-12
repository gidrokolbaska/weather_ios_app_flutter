// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/weather_code_formatter.dart';

class HourlyBlockWidget extends StatelessWidget {
  const HourlyBlockWidget({
    super.key,
    required this.hourlyDates,
    required this.hourlyTemps,
    required this.weatherCodes,
  });
  final List<DateTime> hourlyDates;
  final List<double> hourlyTemps;
  final List<int> weatherCodes;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 0, right: 8),
      scrollDirection: Axis.horizontal,
      itemCount: hourlyDates.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('HH').format(hourlyDates[index]),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              iconFromWeatherCode(weatherCodes[index], hourlyDates[index]),
              color: Colors.white,
            ),
            Text(
              '${hourlyTemps[index].round()}°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 10,
        );
      },
    );
  }
}
