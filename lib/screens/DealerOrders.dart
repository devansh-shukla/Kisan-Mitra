import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_mitra1/screens/Loading.dart';

class DealerOrders extends StatefulWidget {
  @override
  _DealerOrdersState createState() => _DealerOrdersState();
}

class _DealerOrdersState extends State<DealerOrders> {
  var user = FirebaseAuth.instance.currentUser.uid;
  List<String> url = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/1024px-Tomato_je.jpg',
    'https://www.foodpoisonjournal.com/files/2020/08/salmonella3.jpg',
    'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/278858_2200-732x549.jpg',
    'https://cisock.files.wordpress.com/2019/06/potato-1.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    Stream collectionStream = FirebaseFirestore.instance.collection('orders').where('from',isEqualTo: user).snapshots();
    Future<String> myFunc(id){
       return FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return documentSnapshot.data()['full_name'];
        }
        else return " ";
      });
    }
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: collectionStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
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
              return FutureBuilder(
                 future: myFunc(document.data()['to']),
                 builder: (BuildContext context, AsyncSnapshot<String> text){
                   if(!text.hasData)
                     return Loading();
                   else
                   return
                 Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(document.data()['commodity'],style: TextStyle(fontSize: 30),),
                            Text('Quantity :'+document.data()['quantity']+' Kg'),
                            Text('Total amount :'+document.data()['total_price'].toString()),
                            Text('Farmer\'s name :'+ text.data),
                            SizedBox(height: 7,),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:BorderRadius.circular(10),
                                  child: Container(
                                    height:22,
                                    width:100,
                                    color:document.data()['status']=='Approved'?Colors.green:Colors.red,
                                    child: Center(child: Text(document.data()['status'],style: TextStyle(color: Colors.white),)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius:BorderRadius.circular(10),
                                  child: Container(
                                    height:22,
                                    width:100,
                                    color:document.data()['paymentStatus']=='paid'?Colors.green:Colors.red,
                                    child: Center(child: Text(document.data()['paymentStatus'],style: TextStyle(color: Colors.white),)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,)
                          ],
                        ),
                    ClipRRect(
                      borderRadius:BorderRadius.circular(8),
                      child: Image.network(
                        url[no],

                        height: 70,
                        scale: 1,
                      ),
                    ),

                      ],
                    ),
                  ),
                );}
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
