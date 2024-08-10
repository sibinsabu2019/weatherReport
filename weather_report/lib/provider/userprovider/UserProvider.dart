import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_report/Model/userModel.dart';

import 'package:weather_report/Model/weatherModel.dart';


class Userprovider extends ChangeNotifier {
  
   bool signUp=false;
  User? user = FirebaseAuth.instance.currentUser;
  String Error="";
  Future<void>register({required String email, required String password, required String name})async
  {
     try{
   UserCredential credential= await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if(credential.user!.email==email)
      {
         log(".....");
      try{

        userModel UserModel=userModel();
        UserModel.email=email;
        UserModel.password=password;
        UserModel.name=name;
        
       Map<String,dynamic>data= UserModel.toJson();
        FirebaseFirestore.instance.collection("User").doc(user!.uid).set(data);
        signUp=true;
        notifyListeners();
      }on FirebaseException catch(ex)
      {
        Error=ex.message.toString();
        notifyListeners();
      }
      }
      else{
        log("not registerd");
      }
     
     }on FirebaseAuthException
     catch(ex)
     {
      signUp=false;
       Error=ex.message.toString();
       notifyListeners();
     }
  }

  Future<void> weatherSnd(Weather Weather) async {
    
    log("Starting to send weather data...");
    
    Map<String, dynamic> data = Weather.toJson();
    
    try {
      await FirebaseFirestore.instance.collection(user!.uid.toString()).doc(Weather.country.toString())
          .set(data)
          .then((value) => log("Weather data sent successfully!"));
    } on FirebaseException catch (ex) {
      log("FirebaseException: ${ex.message}");
    } catch (e) {
      log("Error: $e");
    }
    
    log(data.toString());
  }

  Future<List<Map<String, dynamic>>> fetchWeatherData() async {
         final CollectionReference countries = FirebaseFirestore.instance.collection(user!.uid.toString());

    try {
      final querySnapshot = await countries.get();
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
    
      print('Error fetching weather data: $e');
      return [];
    }
  }
   Future<Map<String, dynamic>> fetchUserData() async {
    User? user=FirebaseAuth.instance.currentUser;
   final CollectionReference _adminCollection = FirebaseFirestore.instance.collection('User');

    try {
      DocumentSnapshot docSnapshot = await _adminCollection.doc(user!.uid).get();
      return docSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
  
}
