import 'package:fake_to_nahin/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../globals.dart' as globals;

class PostScreen extends StatefulWidget {
  PostModel post;
  PostScreen(this.post);

  @override
  _PostScreenState createState() => _PostScreenState(post);
}

class _PostScreenState extends State<PostScreen> {
  PostModel post;
  _PostScreenState(this.post);

  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Fake To Nahin',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            child: Card(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: Colors.grey,
                            width: 2,
                            style: BorderStyle.values[1])),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          children: [
                            Column(children: [
                              RichText(
                                  text: TextSpan(
                                      text: post.title,
                                      style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.lightBlue[800],
                                          fontWeight: FontWeight.bold))),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(post.username,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                  Text(post.dateCreated,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey))
                                ],
                              ),
                              FractionallySizedBox(
                                  widthFactor: 0.95,
                                  child: Image.network(
                                    post.mediaPath,
                                    fit: BoxFit.fitWidth,
                                  )),
                              Text("Description\n",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              RichText(
                                  text: TextSpan(
                                      text: post.description,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black))),
                              Container(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            'Links to Resources',
                                            style: TextStyle(
                                                color: Colors.lightBlue[800],
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: RaisedButton(
                                              onPressed: () {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Enter a link'),
                                                      content:Column(children: [
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      'Enter link here'),
                                                        ),
                                                        RaisedButton(onPressed: (){
                                                         
                                                        },child:Text('post'))
                                                      ]),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'Post a Link',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              color: Colors.lightBlue[800],
                                            ))
                                      ],
                                    ),
                                    StreamBuilder(
                                        stream: Firestore.instance
                                            .collection('post')
                                            .document()
                                            .collection('comments')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return Text('No comments yet!!');
                                          return ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                  .data.documents.length,
                                              itemBuilder: (context, index) =>
                                                  _buildCommentCards(
                                                      context,
                                                      snapshot.data
                                                          .documents[index]));
                                        })
                                  ]))
                            ])
                          ],
                        ))))));
  }

  Widget _buildCommentCards(BuildContext context, DocumentSnapshot document) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Column(children: [
        Row(
          children: [
            (!document['imagePath'] == null)
                ? (Image.asset('assets/img/as.png'))
                : (Image.network(document['imagePath'])),
            Text(document['username'])
          ],
        ),
        Row(children: [Text(document['dateCreated'])]),
        InkWell(
          onTap: () => launch(document['link']),
          child: RichText(text: TextSpan(text: document['link'])),
        )
      ]),
    );
  }
}
