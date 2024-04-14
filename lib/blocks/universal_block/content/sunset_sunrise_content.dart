import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_drawing/path_drawing.dart';
import 'dart:ui' as ui;

class SunsetSunriseWidget extends StatelessWidget {
  const SunsetSunriseWidget({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.dayLightDuration,
  });
  final DateTime sunrise;
  final DateTime sunset;
  final double dayLightDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomPaint(
            painter: DashedArc(
              color: Colors.white,
              text: intToTimeLeft(
                dayLightDuration.toInt(),
              ),
            ),
            child: const Center(
                child: FittedBox(
              child: Text(
                'Световой день',
                style: TextStyle(color: Colors.white),
              ),
            )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  CupertinoIcons.sunrise_fill,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  DateFormat('HH:mm').format(sunrise.add(
                      Duration(hours: DateTime.now().timeZoneOffset.inHours))),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  CupertinoIcons.sunset_fill,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  DateFormat('HH:mm').format(sunset.toLocal().add(
                      Duration(hours: DateTime.now().timeZoneOffset.inHours))),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

String intToTimeLeft(int value) {
  int h, m;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

  String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

  String result = "$hourLeft ч $minuteLeft мин";

  return result;
}

class DashedArc extends CustomPainter {
  final Color color;
  final String text;

  DashedArc({
    required this.color,
    required this.text,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double dashSize = 4;
    const double gapSize = 8;
    canvas.save();
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );
    final offset = Offset(
      (size.width - textPainter.width) * 0.5,
      6,
    );

    canvas.clipRect(
        Rect.fromLTWH(offset.dx, 0, textPainter.width, textPainter.height + 6),
        clipOp: ui.ClipOp.difference);

    canvas.drawPath(
        dashPath(
            Path()
              ..moveTo(30 / 2, size.height - 5)
              ..arcToPoint(Offset(size.width - 30 / 2, size.height - 5),
                  radius: const Radius.circular(1), largeArc: false),
            dashArray: CircularIntervalList<double>([dashSize, gapSize]),
            dashOffset: DashOffset.percentage(0.004)),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = dashSize);
    canvas.restore();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(DashedArc oldDelegate) {
    return oldDelegate.color != color;
  }
}
