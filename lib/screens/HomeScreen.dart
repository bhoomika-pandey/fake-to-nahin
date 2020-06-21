import 'package:fake_to_nahin/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerButton(),
      ),
      appBar: AppBar(
        title: Text(
          'Fake To Nahin',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          // New Post Button
          RaisedButton(
            splashColor: Colors.white54,
            color: Colors.lightBlue[800],
            onPressed: () {
              Navigator.pushNamed(context, "CreatePost");
            },
            child: Row(children: [
              Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              Text(
                'New Post',
                style: TextStyle(color: Colors.white,fontSize: 20),
              )
            ]),
          )
        ],
      ),
      body: Container(
        alignment:Alignment.topCenter,
        padding: EdgeInsets.all(5),
        child: StreamBuilder(
          stream: Firestore.instance.collection('post').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index) => _buildPostCard(context, snapshot.data.documents[index])
            );
          }
        )
      )
    );
  }

  Widget _buildPostCard(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'Post');
        },
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: Colors.grey,
              width: 2,
              style: BorderStyle.values[1]
            )
          ),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                RichText(
                  text: TextSpan(
                    text: document['title'],
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.lightBlue[800],
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( document['username'],
                      style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold
                      )
                    ),
                    Text(document['dateCreated'].toDate().toString(),
                      style:
                        TextStyle(fontSize: 20, color: Colors.grey
                      )
                    )
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 0.95,
                  child:(document['imagePath']!=null) ?Image.network(
                    document['imagePath'],fit: BoxFit.fitWidth,
                  ):Text('')
                ),
                Text("Description\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                  )
                ),
                RichText(
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  text: TextSpan(
                    text: document['description'],
                    style: TextStyle(
                      fontSize: 18, color: Colors.black
                    )
                  )
                ),
                Text('Read More and View Resources',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
  String formatTimestamp(int timestamp) {
      var format = new DateFormat('d MMM, hh:mm a');
      var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return format.format(date);
    }
}