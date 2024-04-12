import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/network/dio_client.dart';
import 'package:weather_app/network/rest_client.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, MyWeatherState> {
  WeatherBloc({required this.dioClient})
      : super(MyWeatherState(loading: true, hasError: false)) {
    on<MyWeatherLoadingEvent>(_onMyWeatherLoadingEvent);
    add(MyWeatherLoadingEvent());
  }
  final DioClient dioClient;
  Future<void> _onMyWeatherLoadingEvent(
      MyWeatherLoadingEvent event, Emitter<MyWeatherState> emit) async {
    try {
      final weatherData = await dioClient.getWeather();

      emit(state.copyWith(loading: false, weatherData: weatherData));
    } catch (e) {
      emit(state.copyWith(hasError: true));
    }
  }
}
