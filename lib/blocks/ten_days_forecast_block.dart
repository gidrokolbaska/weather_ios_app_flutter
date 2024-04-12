import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/network/rest_client.dart';
import 'package:weather_app/utils/weather_code_formatter.dart';

class TenDaysForecastWidget extends StatelessWidget {
  const TenDaysForecastWidget({
    super.key,
    required this.dailyData,
  });
  final Daily dailyData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dailyData.time.indexed
          .map(
            (element) => ForecastRow(
              day: DateFormat('EE').format(element.$2).toUpperCase(),
              weatherIcon: iconFromWeatherCode(
                  dailyData.weatherCode[element.$1], element.$2),
              tempMin: dailyData.temperature2MMin[element.$1].toInt(),
              tempMax: dailyData.temperature2MMax[element.$1].toInt(),
              windSpeed: dailyData.windSpeed[element.$1],
            ),
          )
          .toList(),
      // [
      //   ForecastRow(
      //     day: 'Пн',
      //     weatherIcon: Icons.radar_outlined,
      //     tempMin: -1,
      //     tempMax: 10,
      //     windSpeed: 3,
      //   ),
      //   ForecastRow(
      //     day: 'Вт',
      //     weatherIcon: Icons.close,
      //     tempMin: 15,
      //     tempMax: 20,
      //     windSpeed: 4,
      //   ),
      //   ForecastRow(
      //     day: 'Ср',
      //     weatherIcon: Icons.close_fullscreen_rounded,
      //     tempMin: -3,
      //     tempMax: 14,
      //     windSpeed: 8,
      //   ),
      //   ForecastRow(
      //     day: 'Чт',
      //     weatherIcon: Icons.class_outlined,
      //     tempMin: -2,
      //     tempMax: 19,
      //     windSpeed: 1,
      //   ),
      //   ForecastRow(
      //     day: 'Пт',
      //     weatherIcon: Icons.class_outlined,
      //     tempMin: -2,
      //     tempMax: 19,
      //     windSpeed: 1,
      //   ),
      // ],
    );
  }
}

class ForecastRow extends StatelessWidget {
  const ForecastRow(
      {super.key,
      required this.day,
      required this.weatherIcon,
      required this.tempMin,
      required this.tempMax,
      required this.windSpeed});
  final String day;
  final IconData weatherIcon;
  final int tempMin;
  final int tempMax;
  final double windSpeed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Icon(
              weatherIcon,
              color: Colors.white,
              size: 20,
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade300,
                ),
                '$tempMin°',
                textAlign: TextAlign.right,
              )),
          Expanded(
              flex: 2,
              child: Text(
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
                '$tempMax°',
                textAlign: TextAlign.right,
              )),
          Expanded(
            flex: 3,
            child: Text(
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.white,
              ),
              '${windSpeed.round()} м/с',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
