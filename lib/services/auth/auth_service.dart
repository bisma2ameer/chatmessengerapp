import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier{
  //instanceof auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign in user
  Future<UserCredential> signInWithEmailandPassword (String email, String password) async {

    try{
      //sign in
      UserCredential userCredential = 
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
      //add a new doc for the user in users collection if it doesn't already exists
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true ));
      return userCredential; 
    } 
    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }

  }
  //create a new user
  Future<UserCredential> signUpWithEmailandPassword(String email, password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
      
      //after creating the user, create a new document for the user in the users collection
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;

    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }

  }



  //sign out user
  Future <void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

}