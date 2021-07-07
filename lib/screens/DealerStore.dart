import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_mitra1/screens/DealerCart.dart';
import 'package:kisan_mitra1/screens/Loading.dart';
import 'package:url_launcher/url_launcher.dart';
class DealerStore extends StatefulWidget {
  @override
  _DealerStoreState createState() => _DealerStoreState();
}

class _DealerStoreState extends State<DealerStore> {
  User user = FirebaseAuth.instance.currentUser;
  var commodity = [];
  var userData = [];


  List<String> url = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/1024px-Tomato_je.jpg',
    'https://www.foodpoisonjournal.com/files/2020/08/salmonella3.jpg',
    'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/278858_2200-732x549.jpg',
    'https://cisock.files.wordpress.com/2019/06/potato-1.jpg'
  ];
  @override
  Widget build(BuildContext context) {
  CollectionReference users = FirebaseFirestore.instance.collection('commodities');

    return Container(
      color: Theme.of(context).primaryColorLight,
      child: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
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
             return Padding(
               padding: const EdgeInsets.fromLTRB(11.0, 11, 11, 0),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: Container(
                   height: 170,
                   width: MediaQuery.of(context).size.width,

                   child: new Card(
                     child: Column(
                       children: [
                         Row(
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
                                   Text("Name: "+document.data()['name'],style: TextStyle(
                                       color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                                   ),),
                                   Text("Location: "+document.data()['address'][0],style: TextStyle(
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
                         Divider(
                           height: 5,
                           thickness: 1,
                           color: Colors.black,
                         ),
                         Expanded(
                           child: Row(
                             children: [
                               Expanded(
                                 child: FlatButton(
                                   color:Colors.green[100],
                                   onPressed:()async{
                                     var phone = document.data()['mobileNo'];
                                     var url = 'tel:$phone';
                                     if (await canLaunch(url)) {
                                     await launch(url);
                                     } else {
                                     throw 'Could not launch $url';
                                     }
                                   },
                                   child: Container(child: Icon(Icons.call,size: 30,color: Colors.green,),
                                   height: 45
                                   ),
                                 ),
                               ),
                               VerticalDivider(
                                   thickness: 1,
                                 width: 7,
                                 color: Colors.black,
                               ),
                               Expanded(
                                 child: FlatButton(
                                   color:Colors.orange[100],
                                   onPressed: (){
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DealerCart(document,user.uid.toString())));
                                   },
                                   child: Container(child: Icon(
                                     Icons.shopping_cart,size: 30,color: Colors.orange,),
                                     height: 45,
                                   ),
                                 ),
                               ),
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
    );
  }
}
