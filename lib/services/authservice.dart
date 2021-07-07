import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_mitra1/screens/Choice.dart';
import 'package:kisan_mitra1/screens/DealerHome.dart';
import 'package:kisan_mitra1/screens/FarmerHome.dart';
import 'package:kisan_mitra1/screens/Login.dart';

class AuthService {
  static int x;
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            getData(snapshot.data.uid);
            if(x == 1){
              x=1;
              return FarmerHome();}
            else return DealerHome();
          } else {
            return Login();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  Future<void> getData(uid) async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.data()['type'] == "farmer") {
        x=1;
      } else {
        x=2;
      }
    });

  }
}