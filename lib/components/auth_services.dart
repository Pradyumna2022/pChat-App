import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? getCurrentUser(){
    return _auth.currentUser;
  }
  //Login
  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            "uId" : userCredential.user!.uid,
            "email" :  email
          }
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception("Login auth services error : ${e.code}");
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          "uId" : userCredential.user!.uid,
          "email" :  email
        }
      );
      return userCredential;


    } on FirebaseAuthException catch (e) {
      throw Exception("Register auth services error : ${e.code}");
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
