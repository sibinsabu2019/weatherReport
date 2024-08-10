import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final List<dynamic> hourlyWeatherData;

  LineChartWidget({required this.hourlyWeatherData});

  LineChartBarData _buildLineChartBarData() {
    List<FlSpot> spots = hourlyWeatherData.asMap().entries.map((entry) {
      int index = entry.key;
      double tempC = entry.value['temp_c'];
      return FlSpot(index.toDouble(), tempC);
    }).toList();

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: Colors.greenAccent,
      barWidth: 4,
      belowBarData: BarAreaData(show: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: LineChart(
        LineChartData(
          lineBarsData: [_buildLineChartBarData()],
          borderData: FlBorderData(show: true),
          titlesData: const FlTitlesData(show: true),
        ),
      ),
    );
  }
}