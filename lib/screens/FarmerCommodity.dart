import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AddCommodity.dart';

class FarmerCommodity extends StatefulWidget {
  @override
  _FarmerCommodityState createState() => _FarmerCommodityState();
}

class _FarmerCommodityState extends State<FarmerCommodity> {
  User user = FirebaseAuth.instance.currentUser;
  List<String> url = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/1024px-Tomato_je.jpg',
    'https://www.foodpoisonjournal.com/files/2020/08/salmonella3.jpg',
    'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/278858_2200-732x549.jpg',
    'https://cisock.files.wordpress.com/2019/06/potato-1.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    Stream collectionStream = FirebaseFirestore.instance
        .collection('commodities')
        .where('uid' , isEqualTo: user.uid)
        .snapshots()
    ;
    return Scaffold(
      body: Container(
        color:Theme.of(context).primaryColorLight,
        child: StreamBuilder<QuerySnapshot>(
          stream: collectionStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('No data');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                int no;
                if(document.data()['commodity']=="Tomato")
                  no = 0;
                else if(document.data()['commodity']=="Onion")
                  no = 1;
                else if(document.data()['commodity']=="Mushroom")
                  no = 2;
                else {
                  no = 3;
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(11.0, 11, 11, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,

                      child: new Card(
                        color:Color(0xfffefae0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius:BorderRadius.circular(8),
                                child: Image.network(
                                   url[no],

                                  height: 100,
                                  scale: 1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Commodity: "+document.data()['commodity'],style: TextStyle(
                                    color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                                  ),),
                                  Text("Price: ₹ " + document.data()['price']+(' (Per Kg)'),style: TextStyle(
                                      color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                                  ),),
                                  Text("Quantity:" +
                                      document.data()["quantity"] +
                                      " Kg",style: TextStyle(
                                      color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddCommodity()));
        },
      ),
    );
  }
}
