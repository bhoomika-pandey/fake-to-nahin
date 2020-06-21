import 'package:fake_to_nahin/models/PostModel.dart';
import 'package:fake_to_nahin/models/ResourceModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../globals.dart' as globals;
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  PostModel post;
  PostScreen(this.post);

  @override
  _PostScreenState createState() => _PostScreenState(post);
}

class _PostScreenState extends State<PostScreen> {
  PostModel post;
  _PostScreenState(this.post);
  TextEditingController resourceController = TextEditingController();

  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fake To Nahin',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            post.username == globals.currentUser.username
                ? RaisedButton(
                    textTheme: ButtonTextTheme.primary,
                    color: Theme.of(context).primaryColor,
                    splashColor: Colors.white54,
                    onPressed: () =>
                        deletePost().then((value) => {Navigator.pop(context)}),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.delete),
                        Text("Delete Post", style: TextStyle(fontSize: 17))
                      ],
                    ),
                  )
                : Text("")
          ],
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: ListView(
              primary: true,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(post.username,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(post.dateCreated,
                          style: TextStyle(fontSize: 20, color: Colors.grey))
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
                          style: TextStyle(fontSize: 18, color: Colors.black))),
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
                                          title: Text('Enter a link'),
                                          content: Column(children: [
                                            TextField(
                                              controller: resourceController,
                                              decoration: InputDecoration(
                                                  hintText: 'Enter link here'),
                                            ),
                                            RaisedButton(
                                                onPressed: () {
                                                  addResourceToPost().then(
                                                      (value) => {
                                                            Navigator.of(
                                                                    context)
                                                                .pop()
                                                          });
                                                },
                                                child: Text('Post'))
                                          ]),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Post a Link',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  color: Colors.lightBlue[800],
                                ))
                          ],
                        ),
                        Column(children: <Widget>[
                          StreamBuilder(
                              stream: Firestore.instance
                                  .collection('posts')
                                  .document(post.id)
                                  .collection('resources')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Text('No comments yet!!');
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (context, index) =>
                                        _buildCommentCards(context,
                                            snapshot.data.documents[index]));
                              })
                        ])
                      ]))
                ])
              ],
            )));
  }

  Future addResourceToPost() async {
    ResourceModel newResource = ResourceModel(
        globals.currentUser.username,
        DateFormat("d MMM yyyy, h:mm a").format(DateTime.now()),
        resourceController.text);

    await Firestore.instance
        .collection('posts')
        .document(post.id)
        .collection('resources')
        .add(newResource.toMap());
  }

  Widget _buildCommentCards(BuildContext context, DocumentSnapshot document) {
    var resource = ResourceModel.fromObject(document);
    resource.id = document.documentID;

    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '@' + resource.username,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                resource.dateCreated,
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
          InkWell(
            onTap: () => launchURL(resource.link),
            child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: resource.link,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline))),
          )
        ],
      ),
    );
  }

  launchURL(link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  Future deletePost() async {
    // delete all links to the post
    await Firestore.instance
        .collection("posts")
        .document(post.id)
        .collection('resources')
        .getDocuments()
        .then((snapshot) => {
              for (DocumentSnapshot ds in snapshot.documents)
                {ds.reference.delete()}
            });

    // delete post
    await Firestore.instance.collection("posts").document(post.id).delete();
  }
}
