import 'package:flutter/material.dart';

class WeatherReportGrid extends StatelessWidget {
  final List<dynamic> hourlyWeatherData;

  const WeatherReportGrid({super.key, required this.hourlyWeatherData});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3,
      ),
      itemCount: hourlyWeatherData.length,
      itemBuilder: (context, index) {
        final weatherData = hourlyWeatherData[index];
        String time = weatherData['time'];
        double tempC = weatherData['temp_c'];

        return Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${tempC.toStringAsFixed(1)}°C',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}