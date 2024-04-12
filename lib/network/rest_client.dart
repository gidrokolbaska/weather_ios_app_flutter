import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://api.open-meteo.com/v1')
abstract class WeatherRestClient {
  factory WeatherRestClient(Dio dio, {String baseUrl}) = _WeatherRestClient;

  @GET('/forecast')
  Future<WeatherDataModel> getWeather(
    @Query('latitude') double lat,
    @Query('longitude') double lon,
    @Query('current') String current,
    @Query('hourly') String hourly,
    @Query('daily') String daily,
    @Query('wind_speed_unit') String windSpeedUnit,
    @Query('timezone') String timezone,
  );
}

@JsonSerializable()
class WeatherDataModel {
  final double latitude;
  final double longitude;
  final Current current;
  final Hourly hourly;
  final Daily daily;

  WeatherDataModel({
    required this.latitude,
    required this.longitude,
    required this.current,
    required this.hourly,
    required this.daily,
  });
  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDataModelToJson(this);
}

@JsonSerializable()
class Current {
  final DateTime time;
  final int interval;
  @JsonKey(name: 'temperature_2m')
  final double temperature2m;
  @JsonKey(name: 'apparent_temperature')
  final double feelsLike;
  @JsonKey(name: 'relative_humidity_2m')
  final int relativeHumidity2m;
  final double precipitation;
  @JsonKey(name: 'surface_pressure')
  final double surfacePressure;
  @JsonKey(name: 'wind_speed_10m')
  final double windSpeed10m;
  @JsonKey(name: 'wind_direction_10m')
  final int windDirection10m;
  @JsonKey(name: 'weather_code')
  final int weatherCode;

  Current({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.feelsLike,
    required this.relativeHumidity2m,
    required this.precipitation,
    required this.surfacePressure,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.weatherCode,
  });
  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentToJson(this);
}

@JsonSerializable()
class Daily {
  final List<DateTime> time;
  @JsonKey(name: 'temperature_2m_max')
  final List<double> temperature2MMax;
  @JsonKey(name: 'temperature_2m_min')
  final List<double> temperature2MMin;
  @JsonKey(name: 'weather_code')
  final List<int> weatherCode;
  @JsonKey(name: 'wind_speed_10m_max')
  final List<double> windSpeed;
  @JsonKey(name: 'sunrise')
  final List<DateTime> sunrise;
  @JsonKey(name: 'sunset')
  final List<DateTime> sunset;

  Daily({
    required this.time,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.weatherCode,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });
  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
  Map<String, dynamic> toJson() => _$DailyToJson(this);
}

@JsonSerializable()
class Hourly {
  final List<DateTime> time;
  @JsonKey(name: 'temperature_2m')
  final List<double> temperature2m;
  @JsonKey(name: 'weather_code')
  final List<int> weatherCode;
  @JsonKey(name: 'uv_index')
  final List<double> uvIndex;
  @JsonKey(name: 'visibility')
  final List<double> visibility;
  @JsonKey(name: 'dew_point_2m')
  final List<double> dewPoint;

  Hourly({
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
    required this.uvIndex,
    required this.visibility,
    required this.dewPoint,
  });
  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}
