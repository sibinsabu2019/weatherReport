import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/UI/Login.dart';
import 'package:weather_report/UI/admin/addlocation.dart';
import 'package:weather_report/provider/adminprovider/authenticate.dart';

class Homeadmin extends StatefulWidget {
  const Homeadmin({super.key});

  @override
  State<Homeadmin> createState() => _HomeadminState();
}

class _HomeadminState extends State<Homeadmin> {
  final CollectionReference adminCollection = FirebaseFirestore.instance.collection('Admin');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: NetworkImage("https://imgs.search.brave.com/a28jwMUqflWJmxOLtEwCBR4MqQO2Dtx82D2lCafCckg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cG5nbWFydC5jb20v/ZmlsZXMvMjEvQWRt/aW4tUHJvZmlsZS1Q/TkctUGhvdG9zLnBu/Zw"),
          ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: Provider.of<Auth>(context, listen: false).fetchAdminData(),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${data['name'] ?? 'No Name'}', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('Email: ${data['email'] ?? 'No Email'}', style: const TextStyle(fontSize: 18)),
                      
                      ],
                    ),
                  );
                }

                return const Center(child: Text('No data found'));
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Add Location'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AddLocationScreen()),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
