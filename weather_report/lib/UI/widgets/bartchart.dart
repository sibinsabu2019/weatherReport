import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  final List<dynamic> hourlyWeatherData;

  const BarChartWidget({super.key, required this.hourlyWeatherData});

  List<BarChartGroupData> _buildBarChartGroups() {
    return hourlyWeatherData.asMap().entries.map((entry) {
      int index = entry.key;
      double tempC = entry.value['temp_c'];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: tempC,
            color: Colors.blueAccent,
            width: 20,
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: _buildBarChartGroups(),
          borderData: FlBorderData(show: false),
          titlesData:const FlTitlesData(show: true),
        ),
      ),
    );
  }
}
