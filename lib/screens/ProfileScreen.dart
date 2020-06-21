import 'package:fake_to_nahin/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:fake_to_nahin/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerButton(),
      appBar: AppBar(
        title: Text('Fake To Nahin',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'ProfileEdit');
            },
            child: Row(children: [Icon(Icons.edit), Text('Edit Profile')]),
            color: Colors.green,
            textColor: Colors.white,
          )
        ],
      ),
      body: ListView(
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
          children: [
            Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://www.eguardtech.com/wp-content/uploads/2018/08/Network-Profile.png')))),
            Text(globals.currentUser.username,
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textAlign: TextAlign.center),
            Card(
                margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                child: Row(
                  children: [
                    Text('Name:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.firstName)+' '+capitalize(globals.currentUser.lastName),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('City:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.city),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('State:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.state),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Country:', style: TextStyle(fontSize: 22)),
                    Text('Country Variable in line58',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Mobile:', style: TextStyle(fontSize: 22)),
                    Text('Mobile Variable in line65',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('E-mail ID:', style: TextStyle(fontSize: 22)),
                    Text('E-mail ID variable in line72',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  children: [
                    Text('Password:', style: TextStyle(fontSize: 22)),
                    RaisedButton(
                        onPressed: () {},
                        child: Text('Change Password',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                )),
          ]),
    );
  }
  
  String capitalize(word) {
      return "${word[0].toUpperCase()}${word.substring(1)}";
    }

}
