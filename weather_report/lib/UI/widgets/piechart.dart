import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class PieChartWidget extends StatelessWidget {
  final List<dynamic> hourlyWeatherData;

  PieChartWidget({required this.hourlyWeatherData});

  List<PieChartSectionData> _buildPieChartSections() {
    Random random = Random();
    return hourlyWeatherData.map((weatherData) {
      String time = weatherData['time'];
      double tempC = weatherData['temp_c'];

      return PieChartSectionData(
        value: tempC,
        title: '$time\n${tempC.toStringAsFixed(1)}°C',
        color: Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1),
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PieChart(
        PieChartData(
          sections: _buildPieChartSections(),
          centerSpaceRadius: 80,
          sectionsSpace: 2,
        ),
      ),
    );
  }
}