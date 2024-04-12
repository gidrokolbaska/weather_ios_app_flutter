import 'package:flutter/material.dart';
import 'package:weather_app/blocks/universal_block/content/uvi_index_progress_bar_widget.dart';

class UviIndexContentWidget extends StatelessWidget {
  const UviIndexContentWidget({super.key, required this.uviIndex});
  final double uviIndex;
  String calculatedUviLevelString(double uviIndex) {
    if (uviIndex >= 0 && uviIndex < 3) {
      return "Низкий";
    } else if (uviIndex >= 3 && uviIndex < 6) {
      return "Умеренный";
    } else if (uviIndex >= 6 && uviIndex < 8) {
      return "Высокий";
    } else if (uviIndex >= 8 && uviIndex < 11) {
      return "Очень высокий";
    } else {
      return "Крайне высокий";
    }
  }

  final double maxUviIndex = 11;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          uviIndex.round().toString(),
          style: const TextStyle(color: Colors.white, fontSize: 35, height: 1),
        ),
        FittedBox(
          child: Text(
            calculatedUviLevelString(uviIndex),
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1,
            ),
          ),
        ),
        UviProgressBarWidget(
          uviIndex: uviIndex,
        ),
      ],
    );
  }
}
