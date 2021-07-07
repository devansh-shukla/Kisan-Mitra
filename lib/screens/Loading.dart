import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_mitra1/styles/size.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColorLight,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SpinKitSpinningCircle(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          ),
        ),

      ],
    );

  }
}