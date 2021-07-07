import 'package:flutter/material.dart';
class Button extends StatelessWidget {
 final String text;
 final Function onpressed;

  const Button({Key key, this.text, this.onpressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 60,
      width: 346,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(196, 135, 198, .3),
              blurRadius: 20,
              offset: Offset(0, 10),
            )
          ]
      ),

      child: RaisedButton(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        color: Colors.cyan,
        onPressed: onpressed,
        child: Text(
          text, style: TextStyle(color: Colors.white, fontSize:
        20),),),
    );
  }
}
