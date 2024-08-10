import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ScatterChartWidget extends StatelessWidget {
  final List<dynamic> hourlyWeatherData;

  const ScatterChartWidget({super.key, required this.hourlyWeatherData});

  List<ScatterSpot> _buildScatterSpots() {
    return hourlyWeatherData.asMap().entries.map((entry) {
      int index = entry.key;
      double tempC = entry.value['temp_c'];
      return ScatterSpot(index.toDouble(), tempC);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: _buildScatterSpots(),
          borderData: FlBorderData(show: true),
          titlesData: const FlTitlesData(show: true),
        ),
      ),
    );
  }
}