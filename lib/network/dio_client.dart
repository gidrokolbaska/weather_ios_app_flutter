import 'package:dio/dio.dart';
import 'package:weather_app/network/rest_client.dart';

class DioClient {
  DioClient();
  late final Dio _dio;
  late final WeatherRestClient client;

  void initRestApi() {
    _dio = Dio();
    // _dio.interceptors.add(
    //   PrettyDioLogger(
    //       requestHeader: true,
    //       requestBody: true,
    //       responseBody: true,
    //       responseHeader: false,
    //       error: true,
    //       compact: true,
    //       maxWidth: 90),
    // );
    client = WeatherRestClient(_dio);
  }

  Future<WeatherDataModel> getWeather() async {
    return await client.getWeather(
        59.9311,
        30.3609,
        'temperature_2m,relative_humidity_2m,precipitation,surface_pressure,wind_speed_10m,wind_direction_10m,weather_code,apparent_temperature',
        'temperature_2m,weather_code,uv_index,visibility,dew_point_2m',
        'weather_code,temperature_2m_max,temperature_2m_min,wind_speed_10m_max,sunrise,sunset',
        'ms',
        'Europe/Moscow');
  }
}
