import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LocationService {
  static Future<void> addLocationToFirestore({
    required BuildContext context,
    required String country,
    required String state,
    required String district,
    required String city,
    required TextEditingController countryController,
    required TextEditingController stateController,
    required TextEditingController districtController,
    required TextEditingController cityController,
  }) async {
    if (country.isEmpty || state.isEmpty || district.isEmpty || city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      CollectionReference locations = FirebaseFirestore.instance.collection('locations');

      DocumentReference countryRef = locations.doc(country);
      DocumentReference stateRef = countryRef.collection('states').doc(state);
      DocumentReference districtRef = stateRef.collection('districts').doc(district);
      DocumentReference cityRef = districtRef.collection('cities').doc(city);

      await countryRef.set({'country': country}, SetOptions(merge: true));
      await stateRef.set({'state': state}, SetOptions(merge: true));
      await districtRef.set({'district': district}, SetOptions(merge: true));
      await cityRef.set({
        'country': country,
        'state': state,
        'district': district,
        'city': city,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location added successfully')),
      );

      countryController.clear();
      stateController.clear();
      districtController.clear();
      cityController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add location: $e')),
      );
    }
  }
}
