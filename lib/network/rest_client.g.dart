// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDataModel _$WeatherDataModelFromJson(Map<String, dynamic> json) =>
    WeatherDataModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      current: Current.fromJson(json['current'] as Map<String, dynamic>),
      hourly: Hourly.fromJson(json['hourly'] as Map<String, dynamic>),
      daily: Daily.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherDataModelToJson(WeatherDataModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'current': instance.current,
      'hourly': instance.hourly,
      'daily': instance.daily,
    };

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      time: DateTime.parse(json['time'] as String),
      interval: json['interval'] as int,
      temperature2m: (json['temperature_2m'] as num).toDouble(),
      feelsLike: (json['apparent_temperature'] as num).toDouble(),
      relativeHumidity2m: json['relative_humidity_2m'] as int,
      precipitation: (json['precipitation'] as num).toDouble(),
      surfacePressure: (json['surface_pressure'] as num).toDouble(),
      windSpeed10m: (json['wind_speed_10m'] as num).toDouble(),
      windDirection10m: json['wind_direction_10m'] as int,
      weatherCode: json['weather_code'] as int,
    );

Map<String, dynamic> _$CurrentToJson(Current instance) => <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'interval': instance.interval,
      'temperature_2m': instance.temperature2m,
      'apparent_temperature': instance.feelsLike,
      'relative_humidity_2m': instance.relativeHumidity2m,
      'precipitation': instance.precipitation,
      'surface_pressure': instance.surfacePressure,
      'wind_speed_10m': instance.windSpeed10m,
      'wind_direction_10m': instance.windDirection10m,
      'weather_code': instance.weatherCode,
    };

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      time: (json['time'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      temperature2MMax: (json['temperature_2m_max'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      temperature2MMin: (json['temperature_2m_min'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      weatherCode:
          (json['weather_code'] as List<dynamic>).map((e) => e as int).toList(),
      windSpeed: (json['wind_speed_10m_max'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      sunrise: (json['sunrise'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      sunset: (json['sunset'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'time': instance.time.map((e) => e.toIso8601String()).toList(),
      'temperature_2m_max': instance.temperature2MMax,
      'temperature_2m_min': instance.temperature2MMin,
      'weather_code': instance.weatherCode,
      'wind_speed_10m_max': instance.windSpeed,
      'sunrise': instance.sunrise.map((e) => e.toIso8601String()).toList(),
      'sunset': instance.sunset.map((e) => e.toIso8601String()).toList(),
    };

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      time: (json['time'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      temperature2m: (json['temperature_2m'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      weatherCode:
          (json['weather_code'] as List<dynamic>).map((e) => e as int).toList(),
      windDirection: (json['wind_direction_10m'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      uvIndex: (json['uv_index'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      visibility: (json['visibility'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      dewPoint: (json['dew_point_2m'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'time': instance.time.map((e) => e.toIso8601String()).toList(),
      'temperature_2m': instance.temperature2m,
      'weather_code': instance.weatherCode,
      'wind_direction_10m': instance.windDirection,
      'uv_index': instance.uvIndex,
      'visibility': instance.visibility,
      'dew_point_2m': instance.dewPoint,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _WeatherRestClient implements WeatherRestClient {
  _WeatherRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.open-meteo.com/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WeatherDataModel> getWeather(
    double lat,
    double lon,
    String current,
    String hourly,
    String daily,
    String windSpeedUnit,
    String timezone,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'latitude': lat,
      r'longitude': lon,
      r'current': current,
      r'hourly': hourly,
      r'daily': daily,
      r'wind_speed_unit': windSpeedUnit,
      r'timezone': timezone,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<WeatherDataModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/forecast',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = WeatherDataModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
