import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FarmerOrders extends StatefulWidget {
  @override
  _FarmerOrdersState createState() => _FarmerOrdersState();
}

class _FarmerOrdersState extends State<FarmerOrders> {
  var user = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    Stream collectionStream = FirebaseFirestore.instance.collection('orders').where('to',isEqualTo: user).snapshots();
    return StreamBuilder<QuerySnapshot>(

      stream: collectionStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['commodity']),


            );
          }).toList(),
        );
      },
    );
  }
}

