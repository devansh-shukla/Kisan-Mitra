import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_mitra1/utils/widgets/Button.dart';
import 'package:kisan_mitra1/utils/widgets/myTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddCommodity extends StatefulWidget {
  @override
  _AddCommodityState createState() => _AddCommodityState();
}

class _AddCommodityState extends State<AddCommodity> {
  String dropDownValue;
  TextEditingController nameController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController otherController = TextEditingController();

  Future<void> addCommodity(doc) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'uid':user.uid,
      'commodity': dropDownValue, // John Doe
      'quantity': quantityController.text ,// Stokes and Sons
      'price': priceController.text,
      'other' :otherController.text,// 42
      'time' : DateTime.now(),
      'name':doc.data['full_name'],
      'address':doc.data['address'],
      'mobileNo' : doc.data['mobileNo']

    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  User user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection('commodities');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
          builder:(BuildContext context,AsyncSnapshot snapshot){return Container(

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey)
                  ),
                  width: MediaQuery.of(context).size.width*0.97,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                    value: dropDownValue,
                    style: TextStyle(color: Colors.black),
                    hint: Text('Commodity'),
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                      });
                    },
                    items: <String>['Tomato', 'Onion', 'Mushroom', 'Potato']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
                  ),
                ),
                  SizedBox(height: 10,),
                  MyTextField(name: "Quantity", hintText: "Enter quantity",
                  myController: quantityController,),
                  MyTextField(name: "Price", hintText: "Enter price",myController: priceController,),
                  MyTextField(
                      name: "Other details", hintText: "Enter other details",myController: otherController,),
                  Button(
                    text: "Add",
                    onpressed: () {
                         addCommodity(snapshot);
                         Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );}
        ),
      ),
    );
  }
}
