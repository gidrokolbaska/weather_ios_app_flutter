import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/blocks/ten_days_forecast_block.dart';
import 'package:weather_app/blocks/universal_block/content/feels_like_content.dart';
import 'package:weather_app/blocks/universal_block/content/humidity_content.dart';
import 'package:weather_app/blocks/universal_block/content/pressure_content.dart';
import 'package:weather_app/blocks/universal_block/content/sunset_sunrise_content.dart';
import 'package:weather_app/blocks/universal_block/content/visibility_content.dart';
import 'package:weather_app/blocks/universal_block/content/wind_content.dart';
import 'package:weather_app/blocks/universal_block/universal_block.dart';
import 'package:weather_app/network/rest_client.dart';
import 'package:weather_app/utils/weather_code_formatter.dart';

import 'blocks/universal_block/content/hourly_content.dart';
import 'blocks/universal_block/content/rain_content.dart';
import 'blocks/universal_block/content/uvi_index_content.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key, required this.weatherData});
  final double maxHeight = 200;
  final double collapsedHeight = 80;
  final double collapsedHeightForBigTemp = 120;
  final double collapsedHeightForWeatherMain = 140;
  final double collapsedHeightForWeatherMaxMin = 160;
  final WeatherDataModel weatherData;
  final DateTime now = DateTime.now();
  int calculactedMaxTemp(WeatherDataModel data) {
    DateTime dateWithoutTime = DateTime(now.year, now.month, now.day);
    int index = data.daily.time.indexOf(dateWithoutTime);
    final double maxTemp = data.daily.temperature2MMax.elementAt(index);
    return maxTemp.round();
  }

  int calculactedMinTemp(WeatherDataModel data) {
    DateTime dateWithoutTime = DateTime(now.year, now.month, now.day);
    int index = data.daily.time.indexOf(dateWithoutTime);
    final double minTemp = data.daily.temperature2MMin.elementAt(index);
    return minTemp.round();
  }

  List<DateTime> hourlyDates(WeatherDataModel data) {
    DateTime dateWithTime = DateTime(now.year, now.month, now.day, now.hour);

    int index = data.hourly.time.indexOf(dateWithTime);

    final hourlyDates = data.hourly.time.skip(index).take(24).toList();
    return hourlyDates;
  }

  List<double> hourlyTemps(WeatherDataModel data) {
    DateTime dateWithTime = DateTime(now.year, now.month, now.day, now.hour);

    int index = data.hourly.time.indexOf(dateWithTime);

    final hourlyTemps = data.hourly.temperature2m.skip(index).take(24).toList();
    return hourlyTemps;
  }

  List<int> hourlyWeatherCode(WeatherDataModel data) {
    DateTime dateWithTime = DateTime(now.year, now.month, now.day, now.hour);

    int index = data.hourly.time.indexOf(dateWithTime);

    final hourlyCode = data.hourly.weatherCode.skip(index).take(24).toList();
    return hourlyCode;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBarBuilder(
          backgroundColorAll: Colors.transparent,
          backgroundColorBar: Colors.transparent,
          barHeight: collapsedHeight,
          initialContentHeight: maxHeight,
          collapseLeadingActions: true,
          pinned: true,
          stretch: true,
          stretchConfiguration: OverScrollHeaderStretchConfiguration(),
          leadingActions: [
            (context, expandRatio, barHeight, overlapsContent) {
              return const SizedBox.shrink();
            }
          ],
          contentBuilder: (context, expandRatio, contentHeight, centerPadding,
              overlapsContent) {
            double subtitleOpacity = contentHeight > 120
                ? 0
                : -(contentHeight - 120) / (120 - collapsedHeight);
            double bigTemperatureOpacity =
                ((contentHeight - 140) / (140 - collapsedHeightForBigTemp))
                    .clamp(0, 1);
            double weatherMainOpacity =
                ((contentHeight - 160) / (160 - collapsedHeightForWeatherMain))
                    .clamp(0, 1);
            double weatherMainMaxMinOpacity = ((contentHeight - 180) /
                    (180 - collapsedHeightForWeatherMaxMin))
                .clamp(0, 1);

            return Transform.translate(
              offset: Offset(
                  0,
                  contentHeight < maxHeight
                      ? 0
                      : (contentHeight - maxHeight) / 4),
              child: Column(
                children: [
                  Text(
                    'Санкт-Петербург',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 15)
                      ],
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Opacity(
                    opacity: subtitleOpacity,
                    child: Text(
                      '${weatherData.current.temperature2m.round()}° | ${weatherTypeStringFromWeatherCode(weatherData.current.weatherCode)}',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 20)
                        ],
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: bigTemperatureOpacity,
                    child: Transform.translate(
                      offset: const Offset(16, 0),
                      child: Text(
                        '${weatherData.current.temperature2m.round()}°',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 20)
                          ],
                          color: Colors.white,
                          fontSize: 80,
                          height: 0.8,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Opacity(
                    opacity: weatherMainOpacity,
                    child: Text(
                      weatherTypeStringFromWeatherCode(
                          weatherData.current.weatherCode),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 20)
                          ],
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Opacity(
                    opacity: weatherMainMaxMinOpacity,
                    child: Text(
                      'Макс.: ${calculactedMaxTemp(weatherData)}°, мин.:${calculactedMinTemp(weatherData)}°',
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 20)
                          ],
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        SliverClip(
          child: SliverPadding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 32,
            ),
            sliver: SliverList.list(children: [
              UniversalBlock(
                isFlexible: true,
                icon: Icons.calendar_month_rounded,
                title: 'Почасовой прогноз'.toUpperCase(),
                content: HourlyBlockWidget(
                  hourlyDates: hourlyDates(weatherData),
                  hourlyTemps: hourlyTemps(weatherData),
                  weatherCodes: hourlyWeatherCode(weatherData),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              UniversalBlock(
                icon: Icons.calendar_month_rounded,
                title: 'Прогноз на ${weatherData.daily.time.length} дней'
                    .toUpperCase(),
                content: TenDaysForecastWidget(dailyData: weatherData.daily),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.sun_max_fill,
                      title: 'УФ-ИНДЕКС',
                      content: UviIndexContentWidget(
                        uviIndex: weatherData
                            .hourly.uvIndex[weatherData.hourly.time.indexOf(
                          DateTime(DateTime.now().year, DateTime.now().month,
                              DateTime.now().day, DateTime.now().hour),
                        )],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.sun_dust_fill,
                      title: 'СОЛНЦЕ',
                      content: SunsetSunriseWidget(
                        sunrise: weatherData
                            .daily.sunrise[weatherData.daily.time.indexOf(
                          DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                          ),
                        )],
                        sunset: weatherData
                            .daily.sunset[weatherData.daily.time.indexOf(
                          DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                          ),
                        )],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.wind,
                      title: 'ВЕТЕР',
                      content: WindContentWidget(
                        windAngle: 90 -
                            weatherData.current.windDirection10m.toDouble(),
                        windSpeed: weatherData.current.windSpeed10m,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.drop_fill,
                      title: 'ОСАДКИ',
                      content: RainContentWidget(
                        rain: weatherData.current.precipitation,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.thermometer,
                      title: 'ОЩУЩАЕТСЯ КАК',
                      content: FeelsLikeWidget(
                        tempFeelsLike: weatherData.current.feelsLike,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.drop,
                      title: 'ВЛАЖНОСТЬ',
                      content: HumidityWidget(
                        humidity:
                            weatherData.current.relativeHumidity2m.toDouble(),
                        dewPoint: weatherData
                            .hourly.dewPoint[weatherData.hourly.time.indexOf(
                          DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            DateTime.now().hour,
                          ),
                        )],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.eye_fill,
                      title: 'ВИДИМОСТЬ',
                      content: VisibilityWidget(
                        visibility: weatherData
                            .hourly
                            .visibility[weatherData.hourly.time
                                .indexOf(
                                  DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    DateTime.now().hour,
                                  ),
                                )
                                .toInt()]
                            .toInt(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: UniversalBlock(
                      isSquared: true,
                      icon: CupertinoIcons.gauge,
                      title: 'ДАВЛЕНИЕ',
                      content: PressureContentWidget(
                        pressure: weatherData.current.surfacePressure.toInt(),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 16,
                color: Colors.white.withOpacity(0.3),
                indent: 8,
                endIndent: 8,
                thickness: 1,
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minSize: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Открыть в картах',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                    Icon(
                      CupertinoIcons.arrow_up_right_square_fill,
                      color: Colors.white.withOpacity(0.5),
                    )
                  ],
                ),
                onPressed: () async {
                  final Uri url = Uri.parse(
                      'http://maps.apple.com/?address=Санкт-Петербург');
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              Divider(
                height: 16,
                color: Colors.white.withOpacity(0.3),
                indent: 8,
                endIndent: 8,
                thickness: 1,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
