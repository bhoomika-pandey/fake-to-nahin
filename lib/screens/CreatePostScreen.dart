import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  var storage = FirebaseStorage.instance;
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
            onPressed: () {UploadPost(titleController, descriptionController);
              Navigator.pushNamedAndRemoveUntil(context,'Home', ModalRoute.withName('/'));
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
        child: ListView(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          children:[
            Text('Title',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.lightBlue[800])),
            TextField(controller: titleController,maxLines:3,keyboardType: TextInputType.multiline,style: TextStyle(fontSize: 20,color:Colors.black),decoration: InputDecoration(hintText:'Please Enter Heading for your post'),),
            Text('Description',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.lightBlue[800])),
            TextField(controller: descriptionController,keyboardType: TextInputType.multiline,maxLines:3,style: TextStyle(fontSize: 20,color:Colors.black),decoration: InputDecoration(hintText:'Please Enter Description for your post'),),
            Row(mainAxisAlignment: MainAxisAlignment.center,children:[
              Column(children:[
                RaisedButton(color: Colors.lightBlue[800],onPressed:(){getImage();},child: Text('Pick an Image',style:TextStyle(fontSize: 18,color:Colors.white,fontWeight:FontWeight.bold)),),
                _image == null ? Text('No Image Selected') : Image.file(_image,width: 350,height: 350,fit: BoxFit.contain,)
              ])
            ]),
            
          ]
        ),
      )
    );
  }
  void UploadPost(titleController,descriptionController){
    Firestore.instance.collection('post').document('title').setData({'title':titleController.runtimeType,'description':descriptionController});
  }
}