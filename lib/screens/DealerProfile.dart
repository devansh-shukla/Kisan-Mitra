import 'package:flutter/material.dart';
 
class DealerProfile extends StatefulWidget {
  @override
  _DealerProfileState createState() => _DealerProfileState();
}

class _DealerProfileState extends State<DealerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Stack(fit: StackFit.loose, children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://i.pinimg.com/564x/51/f6/fb/51f6fb256629fc755b8870c801092942.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 90.0, right: 100.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 25.0,
                          child: new IconButton(
                            icon: Icon(Icons.camera_alt),
                            color: Colors.white,
                            onPressed: (){},
                          ),
                        )
                      ],
                    )),
              ]),
            ),
            Divider(
              height: 50,
              thickness: 3,
              indent: 70,
              endIndent: 70,
            ),
            Center(
              child: Text('Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
            Divider(
              height: 50,
              thickness: 3,
              indent: 70,
              endIndent: 70,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mobile Number',
                  hintText: 'Enter Mobile Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                  hintText: 'Enter Your Address',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pin Code',
                  hintText: 'Enter Your Pin Code',
                ),
              ),
            ),
            Divider(
              height: 30,
              thickness: 3,
              indent: 70,
              endIndent: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.green,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(width: 80,),
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.redAccent,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),

      ),
    );
  }
}
