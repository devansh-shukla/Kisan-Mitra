import 'package:flutter/material.dart';

class SignUpNotifier extends ChangeNotifier{
  String phoneNo, verificationId, smsCode;
  void changeNo(String num){
    phoneNo = num;
    print(phoneNo);
    notifyListeners();
  }
}