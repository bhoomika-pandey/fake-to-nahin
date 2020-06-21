import 'package:fake_to_nahin/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: MyCustomForm()),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  UserModel newUserModel = new UserModel();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            height: 150.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,

                    image: AssetImage('assets/img/logo.png'))),
          ),
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.firstName = value;
            },
          ),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.lastName = value;
            },
          ),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.username = value;
            },
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email Id'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.email = value;
            },
          ),
          TextFormField(
            controller: mobileController,
            decoration: InputDecoration(labelText: 'Mobile'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.mobile = value;
            },
          ),
          TextFormField(
            controller: countryController,
            decoration: InputDecoration(labelText: 'Country'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.country = value;
            },
          ),
          TextFormField(
            controller: stateController,
            decoration: InputDecoration(labelText: 'State'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.state = value;
            },
          ),
          TextFormField(
            controller: cityController,
            decoration: InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.city = value;
            },
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.password = value;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Store user in Database
                _formKey.currentState.save();
                var userMap = newUserModel.toMap();
                final db = Firestore.instance;
                db
                    .collection("users")
                    .document(newUserModel.email)
                    .setData(userMap);
                // return showDialog(
                //   context: context,
                //   builder: (context) {
                //     return AlertDialog(
                //       content: Text(newUserModel.email),
                //     );
                //   },
                // );
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
// ListView(
//             children: <Widget>[
//               TextFormField(
//                 controller: myController,
//                 decoration: InputDecoration(
//                     border: hintText: 'Enter a search term'),
//               ),
//             ],
//           )
