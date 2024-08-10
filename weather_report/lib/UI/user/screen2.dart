import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('locations').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No locations found'));
                }
            
                var countryDocs = snapshot.data!.docs;
            
                return ListView.builder(
                  itemCount: countryDocs.length,
                  itemBuilder: (context, index) {
                    var countryDoc = countryDocs[index];
                    return ExpansionTile(
                      title: Text(countryDoc['country']),
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: countryDoc.reference.collection('states').snapshots(),
                          builder: (context, stateSnapshot) {
                            if (stateSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (!stateSnapshot.hasData || stateSnapshot.data!.docs.isEmpty) {
                              return const ListTile(title: Text('No states found'));
                            }
            
                            var stateDocs = stateSnapshot.data!.docs;
            
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: stateDocs.length,
                              itemBuilder: (context, stateIndex) {
                                var stateDoc = stateDocs[stateIndex];
                                return ExpansionTile(
                                  title: Text(stateDoc['state']),
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: stateDoc.reference.collection('districts').snapshots(),
                                      builder: (context, districtSnapshot) {
                                        if (districtSnapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(child: CircularProgressIndicator());
                                        } else if (!districtSnapshot.hasData || districtSnapshot.data!.docs.isEmpty) {
                                          return const ListTile(title: Text('No districts found'));
                                        }
            
                                        var districtDocs = districtSnapshot.data!.docs;
            
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: districtDocs.length,
                                          itemBuilder: (context, districtIndex) {
                                            var districtDoc = districtDocs[districtIndex];
                                            return ExpansionTile(
                                              title: Text(districtDoc['district']),
                                              children: [
                                                StreamBuilder<QuerySnapshot>(
                                                  stream: districtDoc.reference.collection('cities').snapshots(),
                                                  builder: (context, citySnapshot) {
                                                    if (citySnapshot.connectionState == ConnectionState.waiting) {
                                                      return const Center(child: CircularProgressIndicator());
                                                    } else if (!citySnapshot.hasData || citySnapshot.data!.docs.isEmpty) {
                                                      return const ListTile(title: Text('No cities found'));
                                                    }
            
                                                    var cityDocs = citySnapshot.data!.docs;
            
                                                    return ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemCount: cityDocs.length,
                                                      itemBuilder: (context, cityIndex) {
                                                        var cityDoc = cityDocs[cityIndex];
                                                        return ListTile(
                                                          title: Text(cityDoc['city']),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
