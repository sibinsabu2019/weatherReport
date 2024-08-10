import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_report/UI/widgets/locationService.dart';


class AddLocationScreen extends StatelessWidget {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: countryController,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: stateController,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: districtController,
              decoration: const InputDecoration(
                labelText: 'District',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => LocationService.addLocationToFirestore(
                context: context,
                country: countryController.text.trim(),
                state: stateController.text.trim(),
                district: districtController.text.trim(),
                city: cityController.text.trim(),
                countryController: countryController,
                stateController: stateController,
                districtController: districtController,
                cityController: cityController,
              ),
              child: const Text('Add Location'),
            ),
          ],
        ),
      ),
    );
  }
}
