import 'package:adv_flutter_weather/bg/weather_bg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:weather_app/bloc/bloc/weather_bloc.dart';
import 'package:weather_app/network/dio_client.dart';
import 'package:weather_app/utils/weather_code_formatter.dart';
import 'package:weather_app/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final DioClient dioClient;
  @override
  void initState() {
    dioClient = DioClient();
    dioClient.initRestApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(dioClient: dioClient),
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          top: false,
          bottom: false,
          child: SizedBox.expand(
            child: BlocBuilder<WeatherBloc, MyWeatherState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      radius: 30,
                    ),
                  );
                }
                return Stack(
                  children: [
                    WeatherBg(
                      weatherType: weatherTypeBackgroundFromWeatherCode(
                          state.weatherData!.current.weatherCode,
                          state.weatherData!.current.time),
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                    ),
                    WeatherPage(
                      weatherData: state.weatherData!,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBall extends StatelessWidget {
  final List<Color> colors;
  final Size size;
  const GradientBall({
    super.key,
    required this.colors,
    this.size = const Size.square(150),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
    );
  }
}
