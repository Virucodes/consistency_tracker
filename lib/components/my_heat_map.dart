import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final DateTime startdate;
  final Map<DateTime,int> datasets;
  const MyHeatMap({
    super.key,
    required this.startdate,
    required this.datasets,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
        startDate: startdate,
        endDate: DateTime.now(),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Theme.of(context).colorScheme.secondary,
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        
        colorsets: {
          1: Colors.green.shade200,
          2: Colors.green.shade300,
          3: Colors.green.shade400,
          4: Colors.green.shade500,
          5: Colors.green.shade600,
        });
  }
}
