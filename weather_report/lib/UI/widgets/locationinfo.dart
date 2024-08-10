import 'package:flutter/material.dart';

class LocationInfo extends StatelessWidget {
  final String stateName;
  final String cityName;

  const LocationInfo({super.key, required this.stateName, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'State: $stateName',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'City: $cityName',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}