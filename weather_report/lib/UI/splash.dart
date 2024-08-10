import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_report/UI/Login.dart';
import 'package:weather_report/UI/admin/Home.dart';
import 'package:weather_report/UI/user/HomeUser.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .doc(user.uid)
          .get();

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();

      if (adminSnapshot.exists) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Homeadmin()),
        );
      } else if (userSnapshot.exists) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Homeuser()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
