import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_mitra1/screens/DealerOrders.dart';
import 'package:kisan_mitra1/screens/DealerProfile.dart';
import 'package:kisan_mitra1/screens/DealerStore.dart';
import 'package:kisan_mitra1/screens/Login.dart';

class DealerHome extends StatefulWidget {
  @override
  _DealerHomeState createState() => _DealerHomeState();
}

class _DealerHomeState extends State<DealerHome> {
  int _page = 0;
  String title1;

  void onTabTapped(int index){
    setState(() {
      _page = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [DealerStore(),DealerOrders(),DealerProfile()];
    final List<String> title1 = ["Store","My Orders","Profile"];
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text(title1[_page]),
      ),
      drawer:Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Farmer Name"),
              accountEmail: Text("+91 1234567890"),
              currentAccountPicture: CircleAvatar(
//                child: Text('You'),
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://thumbs.dreamstime.com/z/default-avatar-profile-image-vector-social-media-user-icon-potrait-182347582.jpg"),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
              title: Text(
                'Language',
                textDirection: TextDirection.ltr,
              ),
//              subtitle: Text("English"),
              leading: Icon(Icons.language),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () async {

                print("Selected Language is ");
              },
              subtitle: Text("English"),
            ),
            ListTile(
              title: Text(
                'Address',
                textDirection: TextDirection.ltr,
              ),
              subtitle: Text("Loation"),
              leading: Icon(Icons.location_on),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Edit Profile',
                textDirection: TextDirection.ltr,
              ),
              leading: Icon(Icons.edit),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DealerProfile()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                textDirection: TextDirection.ltr,
              ),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
//
                FirebaseAuth.instance.signOut().then((onValue){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                  print("Signed out successfully");
                }
                );
//                    _signOut();
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Login()),
//                );
              },
            ),
            Divider(
              height: 220.0,
            ),
            ListTile(
              title: Text(
                'Close',
                textDirection: TextDirection.ltr,
              ),
              leading: Icon(Icons.close_fullscreen),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body:_children[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColor,
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 25,color: Colors.white,),
          Icon(Icons.shopping_cart, size: 25,color: Colors.white,),
          Icon(Icons.person, size: 25,color: Colors.white,),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _page, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),*/

    );
  }
}
