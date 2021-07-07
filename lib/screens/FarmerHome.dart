import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_mitra1/screens/Login.dart';
import 'FarmerCommodity.dart';
import 'FarmerOrders.dart';
import 'FarmerProfile.dart';

class FarmerHome extends StatefulWidget {
  @override
  _FarmerHomeState createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  int _page = 0;
  String title1;
  @override
  Widget build(BuildContext context) {

    final List<Widget> _children = [FarmerCommodity(),FarmerOrders(),FarmerProfile()];
    final List<String> title1 = ["My Commodities","Orders","Profile"];
    void onTabTapped(int index){
      setState(() {
        _page = index;
      });
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text(title1[_page]),
      ),
      drawer: Drawer(
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
                final Language langName = await _asyncSimpleDialog(context);
                print("Selected Language is $langName");
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
                  MaterialPageRoute(builder: (context) => FarmerProfile()),
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
          Icon(Icons.receipt, size: 25,color: Colors.white,),
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
enum Language { English, Hindi }

Future<Language> _asyncSimpleDialog(BuildContext context) async {
  return await showDialog<Language>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Language '),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Language.English);
              },
              child: const Text('English'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Language.Hindi);
              },
              child: const Text('Hindi'),
            ),
          ],
        );
      });
}