// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

class MyWeatherState {
  final bool loading;
  final bool hasError;
  final WeatherDataModel? weatherData;

  MyWeatherState(
      {required this.loading, required this.hasError, this.weatherData});

  MyWeatherState copyWith({
    bool? loading,
    bool? hasError,
    WeatherDataModel? weatherData,
  }) {
    return MyWeatherState(
      loading: loading ?? this.loading,
      hasError: hasError ?? this.hasError,
      weatherData: weatherData ?? this.weatherData,
    );
  }
}
