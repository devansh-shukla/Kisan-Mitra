import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String name,hintText;
  final TextEditingController myController;
  const MyTextField({Key key,this.name,this.hintText,this.myController}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          labelText: name,
          hintText: hintText,
        ),
      ),
    );
  }
}
