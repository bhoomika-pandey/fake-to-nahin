import 'package:fake_to_nahin/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:fake_to_nahin/globals.dart' as globals;

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File _image;
  var _uploadedFileURL;
  final picker = ImagePicker();

  PostModel newPost = PostModel();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  var storage = FirebaseStorage.instance.ref();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create New Post',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            RaisedButton(
              textTheme: ButtonTextTheme.primary,
              color: Theme.of(context).primaryColor,
              splashColor: Colors.white54,
              onPressed: () {
                uploadFile().then((downloadUrl) => {
                      uploadPost(titleController.text,
                              descriptionController.text, downloadUrl)
                          .then((value) => {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'Home', ModalRoute.withName('/'))
                              })
                    });
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.publish),
                  Text("Post", style: TextStyle(fontSize: 20))
                ],
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(padding: EdgeInsets.fromLTRB(5, 10, 5, 0), children: [
            Text('Title',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.lightBlue[800])),
            TextField(
              controller: titleController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: 20, color: Colors.black),
              decoration: InputDecoration(
                  hintText: 'Please Enter Heading for your post'),
            ),
            Text('Description',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.lightBlue[800])),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              style: TextStyle(fontSize: 20, color: Colors.black),
              decoration: InputDecoration(
                  hintText: 'Please Enter Description for your post'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                RaisedButton(
                  color: Colors.lightBlue[800],
                  onPressed: () {
                    getImage();
                  },
                  child: Text('Pick an Image',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                _image == null
                    ? Text('No Image Selected')
                    : Image.file(
                        _image,
                        width: 350,
                        height: 350,
                        fit: BoxFit.contain,
                      )
              ])
            ]),
          ]),
        ));
  }

  Future uploadPost(
      String title, String description, String downloadUrl) async {
    await Firestore.instance.collection('post').add({
      'title': title,
      'description': description,
      'dateCreated': new DateTime.now(),
      'username': globals.currentUser.username,
      'imagePath': downloadUrl
    });
  }

  Future<String> uploadFile() async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${Path.basename(_image.path)}');
    final StorageUploadTask uploadTask = storageReference.putFile(_image);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }
}

int currentTimeInSeconds() {
  var ms = (new DateTime.now()).millisecondsSinceEpoch;
  return (ms / 1000).round();
}
