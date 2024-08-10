import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_report/UI/Login.dart';
import 'package:weather_report/UI/user/screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

class Homeuser extends StatefulWidget {
  const Homeuser({super.key});

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  List<Widget> pages = [const Screen1(),LocationListScreen() ,const screen3()];
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    log(index.toString());
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_exploration),
            label: 'Explore',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue[700],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: const Text('User Dashboard'),
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
      body: pages[selectedIndex],
    );
  }
}

class BottomNavItems extends StatelessWidget {
  final IconData icon;
  const BottomNavItems({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 35, color: Colors.blue[700]);
  }
}
