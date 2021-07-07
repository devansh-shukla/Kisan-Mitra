import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kisan_mitra1/screens/Choice.dart';
import 'package:kisan_mitra1/screens/DealerHome.dart';
import 'FarmerHome.dart';

class Login extends StatefulWidget {
  static DocumentSnapshot a;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  _LoginState();
  String phoneNo, smssent, verificationId;
  TextEditingController mobileno = TextEditingController();

  get verifiedSuccess => null;

  Future<void> verfiyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91"+phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
                child: Center(
              child: AlertDialog(
                title: Text('Enter OTP'),
                content: Expanded(
                  child: TextField(
                    onChanged: (value) {
                      this.smssent = value;
                    },
                  ),
                ),
                contentPadding: EdgeInsets.all(10.0),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
//                  FirebaseAuth.instance.currentUser;
                      if (FirebaseAuth.instance.currentUser != null) {
                        Navigator.of(context).pop();

                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Choice()),
                        );*/
                      } else {
                        Navigator.of(context).pop();
                        signIn(smssent);
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            )),
          );
        });
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((users) {
      if( users.additionalUserInfo.isNewUser==true){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Choice(),
        ),
      );}
      else{

        getData(users);
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: TextField(
//              decoration: InputDecoration(
//                hintText: "Enter your phone number",
//              ),
//              onChanged: (value) {
//                this.phoneNo = value;
//              },
//            ),
//          ),
//          SizedBox(
//            height: 10.0,
//          ),
//          RaisedButton(
//            onPressed: verfiyPhone,
//            child: Text(
//              "verify",
//              style: TextStyle(color: Colors.white),
//            ),
//            elevation: 7.0,
//            color: Colors.blue,
//          )
//        ],
//      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.12,
                  ),
                  Center(
                    child: Image(
                      image: AssetImage("assets/logo1.jpg"),
                      height: 120.0,),
                  ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Center(
                child: Text(
                  'KISAN MITRA',
                  style: TextStyle(
                       fontFamily: 'PottaOne',

                      fontSize: 29,
                      color: Colors.green),
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(196, 135, 198, .3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
                        controller: mobileno,
                        onChanged: (value) {
                          this.phoneNo = value;
                        },
                        decoration: InputDecoration(
                           prefix: Text("+91"),
                            border: InputBorder.none,
                            hintText: "Mobile No",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    /* Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      )*/
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
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
                    ]),
                child: RaisedButton(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green,
                  onPressed: () {
                    verfiyPhone();
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> getData(users) async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(users.user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {

      if (documentSnapshot.data()['type']=="farmer") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerHome(),
          ),
                (Route<dynamic> route) => false
        );
      }else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DealerHome(),
          ),
                (Route<dynamic> route) => false
        );
      }
    });
  }
}
//                /* InkWell(
//                  onTap: () {
//                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignUp()));
//                  },
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Text('Not a member?Sign in',
//                        style: TextStyle(color: Colors.blue),),
//                    ],
//        var size = MediaQuery
//        .of(context)
//        .size;
//    return ChangeNotifierProvider<SignUpNotifier>(
//      create: (context)=>SignUpNotifier(),
//      child: Scaffold(
//        body: SingleChildScrollView(
//          child: Container(
//            child: Padding(
//              padding: EdgeInsets.symmetric(horizontal: 40),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  SizedBox(height: size.height * 0.4,),
//                  Text('LOGIN', style: TextStyle(fontStyle: FontStyle.normal,
//                      fontWeight: FontWeight.bold,
//                      fontSize:29, color: Colors.cyan),),
//                  SizedBox(height: size.height * 0.05,),
//                  Container(
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10),
//                        color: Colors.white,
//                        boxShadow: [
//                          BoxShadow(
//                            color: Color.fromRGBO(196, 135, 198, .3),
//                            blurRadius: 20,
//                            offset: Offset(0, 10),
//                          )
//                        ]
//                    ),
//                    child: Column(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.all(10),
//                          decoration: BoxDecoration(
//                              border: Border(bottom: BorderSide(
//                                  color: Colors.grey[200]
//                              ))
//                          ),
//                          child: Consumer<SignUpNotifier>(
//                            builder: (context,SignUpNotifier,child) {
//                              return TextField(
//                                controller: mobileno,
//                                onChanged: (val) {
//                                  SignUpNotifier.changeNo(val);
//
//                                },
//                                decoration: InputDecoration(
//                                    border: InputBorder.none,
//                                    hintText: "Mobile No",
//                                    hintStyle: TextStyle(color: Colors.grey)
//                                ),
//                              );
//
//                            }),
//                        ),
//                       /* Container(
//                          padding: EdgeInsets.all(10),
//                          child: TextField(
//                            decoration: InputDecoration(
//                                border: InputBorder.none,
//                                hintText: "Password",
//                                hintStyle: TextStyle(color: Colors.grey)
//                            ),
//                          ),
//                        )*/
//                      ],
//                    ),
//                  ),
//                  SizedBox(height: size.height * 0.05,),
//                  Container(
//                    height: 60,
//                    width: 346,
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10),
//                        color: Colors.white,
//                        boxShadow: [
//                          BoxShadow(
//                            color: Color.fromRGBO(196, 135, 198, .3),
//                            blurRadius: 20,
//                            offset: Offset(0, 10),
//                          )
//                        ]
//                    ),
//
//                    child: RaisedButton(
//                      elevation: 6,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(10)),
//                      color: Colors.cyan,
//                      onPressed: () {
//                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Choice()));
//                      },
//                      child: Text(
//                        "LOGIN", style: TextStyle(color: Colors.white, fontSize:
//                      20),),),
//                  ),
//                  SizedBox(height: size.height * 0.04,),
//                 /* InkWell(
//                    onTap: () {
//                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignUp()));
//                    },
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        Text('Not a member?Sign in',
//                          style: TextStyle(color: Colors.blue),),
//                      ],
//                    ),
//                  )
//                   */
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
