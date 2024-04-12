import 'package:adv_flutter_weather/utils/weather_type.dart';
import 'package:flutter/cupertino.dart';

IconData iconFromWeatherCode(int weatherCode, DateTime dateTime) {
  switch (weatherCode) {
    case 0:
      return dateTime.hour >= 5 && dateTime.hour <= 21
          ? CupertinoIcons.sun_max_fill
          : CupertinoIcons.moon_stars_fill;
    case 1:
    case 2:
      return dateTime.hour >= 5 && dateTime.hour <= 21
          ? CupertinoIcons.cloud_sun_fill
          : CupertinoIcons.cloud_moon_fill;
    case 3:
    case 45:
    case 48:
      return CupertinoIcons.cloud_fill;
    case 51:
    case 53:
    case 55:
    case 56:
    case 57:
    case 61:
    case 63:
    case 65:
    case 66:
    case 67:
    case 80:
    case 81:
    case 82:
      return CupertinoIcons.cloud_rain_fill;
    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
      return CupertinoIcons.cloud_snow_fill;
    case 95:
    case 96:
    case 99:
      return CupertinoIcons.cloud_bolt_rain_fill;
    default:
      return CupertinoIcons.clear;
  }
}

String weatherTypeStringFromWeatherCode(int weatherCode) {
  switch (weatherCode) {
    case 0:
      return 'Ясно';
    case 1:
    case 2:
      return 'Временами облачно';
    case 3:
    case 45:
    case 48:
      return 'Облачно';
    case 51:
    case 53:
    case 55:
    case 56:
    case 57:
    case 61:
    case 63:
    case 65:
    case 66:
    case 67:
    case 80:
    case 81:
    case 82:
      return 'Дождь';
    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
      return 'Снег';
    case 95:
    case 96:
    case 99:
      return 'Гроза';
    default:
      return "Непонятно";
  }
}

WeatherType weatherTypeBackgroundFromWeatherCode(
    int weatherCode, DateTime dateTime) {
  switch (weatherCode) {
    case 0:
      return dateTime.hour >= 5 && dateTime.hour <= 21
          ? WeatherType.sunny
          : WeatherType.sunnyNight;
    case 1:
    case 2:
      return dateTime.hour >= 5 && dateTime.hour <= 21
          ? WeatherType.cloudy
          : WeatherType.cloudyNight;
    case 3:
    case 45:
    case 48:
      return WeatherType.overcast;
    case 51:
    case 53:
    case 55:
    case 56:
    case 57:
    case 61:
    case 63:
    case 65:
    case 66:
    case 67:
    case 80:
    case 81:
    case 82:
      return WeatherType.middleRainy;
    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
      return WeatherType.middleSnow;
    case 95:
    case 96:
    case 99:
      return WeatherType.storm;
    default:
      return WeatherType.sunny;
  }
}
