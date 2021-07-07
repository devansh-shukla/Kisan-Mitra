import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DealerCart extends StatefulWidget {
  final  DocumentSnapshot d;
  final String x;
  DealerCart(this.d,this.x);
  @override
  _DealerCartState createState() => _DealerCartState();
}

class _DealerCartState extends State<DealerCart> {
  List<String> url = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/1024px-Tomato_je.jpg',
    'https://www.foodpoisonjournal.com/files/2020/08/salmonella3.jpg',
    'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/278858_2200-732x549.jpg',
    'https://cisock.files.wordpress.com/2019/06/potato-1.jpg'
  ];
  CollectionReference users = FirebaseFirestore.instance.collection('orders');
  var totalPrice;
  TextEditingController address = TextEditingController();
  TextEditingController quantity = TextEditingController();
  Future<void> addOrder(data) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'commodity': data['commodity'], // John Doe
      'quantity': quantity.text ,// Stokes and Sons
      'deliveryAddress': address.text,
      'price': data['price'],
      'total_price':totalPrice,
      'time' : DateTime.now(),
      'from':widget.x,
      'to':data['uid'],
      'status':'Pending',
      'paymentStatus':'Unpaid'
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    var data = widget.d.data();
    int no;
    if(data['commodity']=="Tomato")
      no = 0;
    else if(data['commodity']=="Onion")
      no = 1;
    else if(data['commodity']=="Mushroom")
      no = 2;
    else {
      no = 3;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Add to cart'),
        ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width*0.98,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url[no],
                      height: 120,
                      scale: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['commodity'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Text("Farmer's name: "+data['name'],style: TextStyle(
                        color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                    ),),
                    Text("Location: "+data['address'],style: TextStyle(
                        color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                    ),),
                    Text("Price: ₹ " + data['price']+(' (Per Kg)'),style: TextStyle(
                        color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      width: 250,
                      child: TextField(
                        onChanged: (val){
                          setState(() {
                            totalPrice = double.parse(data['price'])*double.parse(val);
                          });
                        },
                        controller: quantity,
                        decoration: InputDecoration(
                          hintText: "Quantity",
                          labelText: "Quantity",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: address,
                        decoration: InputDecoration(
                            hintText: "Address",
                            labelText: "Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    RaisedButton(onPressed: (){
                         addOrder(data);
                         Navigator.of(context).pop();
                    },
                    child: Text('Request order'),
                    ),
                   Text("Total:" + totalPrice.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
