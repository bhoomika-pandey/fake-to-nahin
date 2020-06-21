import 'package:fake_to_nahin/models/UserModel.dart';
import 'package:fake_to_nahin/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerButton(),
        appBar: AppBar(
          title: Text('Fetch Data',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          // actions: [
          //   RaisedButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, 'ProfileEdit');
          //     },
          //     child: Row(children: [Icon(Icons.edit), Text('Edit Profile')]),
          //     color: Colors.green,
          //     textColor: Colors.white,
          //   )
          // ],
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              final userArray = snapshot.data.documents;
              List<UserModel> users = [];
              for (var user in userArray) {
                var newUser = UserModel.withId(
                    user["email"],
                    user["username"],
                    user["first_name"],
                    user["last_name"],
                    user["country"],
                    user["state"],
                    user["city"],
                    user["mobile"],
                    user["password"],
                    user["imagePath"]);
                users.add(newUser);
              }
              return ListView.builder(
                itemBuilder: (context, index) =>
                    _printData(context, users[index]),
                itemCount: users.length,
              );
            },
          ),
        ));
  }

  Widget _printData(BuildContext context, UserModel user) {
    return Text(user.firstName + user.lastName);
  }
}
