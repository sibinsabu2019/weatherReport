import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier{
  String? Error; 
  bool? success;
Future<void>Login({
  String? email,String? password
})async
{
  try{
  await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
  success=true;
    }
  on FirebaseAuthException catch(ex)
  {
    Error=ex.code;
    success=false;
    notifyListeners();
  }
  

}
 


  Future<Map<String, dynamic>> fetchAdminData() async {
    User? user=FirebaseAuth.instance.currentUser;
   final CollectionReference _adminCollection = FirebaseFirestore.instance.collection('Admin');

    try {
      DocumentSnapshot docSnapshot = await _adminCollection.doc(user!.uid).get();
      return docSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }


}