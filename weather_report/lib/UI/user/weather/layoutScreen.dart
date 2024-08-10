import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_report/UI/widgets/bartchart.dart';
import 'package:weather_report/UI/widgets/chartTitle.dart';
import 'package:weather_report/UI/widgets/linchart.dart';
import 'package:weather_report/UI/widgets/locationinfo.dart';
import 'package:weather_report/UI/widgets/piechart.dart';
import 'package:weather_report/UI/widgets/scatterchart.dart';
import 'package:weather_report/UI/widgets/weatherRep.dart';
import 'dart:math';



class WeatherDetailScreen extends StatelessWidget {
  final String countryName;
  final List<dynamic> hourlyWeatherData;
  final String StateName;
  final String cityName;

  WeatherDetailScreen({
    super.key,
    required this.countryName,
    required this.hourlyWeatherData,
    required this.cityName,
    required this.StateName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details: $countryName'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LocationInfo(stateName: StateName, cityName: cityName),
            ChartTitle(title: 'Pie Chart'),
            PieChartWidget(hourlyWeatherData: hourlyWeatherData),
            ChartTitle(title: 'Bar Chart'),
            BarChartWidget(hourlyWeatherData: hourlyWeatherData),
            ChartTitle(title: 'Line Chart'),
            LineChartWidget(hourlyWeatherData: hourlyWeatherData),
            ChartTitle(title: 'Scatter Chart'),
            ScatterChartWidget(hourlyWeatherData: hourlyWeatherData),
            ChartTitle(title: 'Custom Layout(Grid view)'),
            WeatherReportGrid(hourlyWeatherData: hourlyWeatherData),
          ],
        ),
      ),
    );
  }
}