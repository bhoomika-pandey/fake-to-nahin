import 'package:fake_to_nahin/screens/MyPostsScreen.dart';
import 'package:fake_to_nahin/screens/SavedPostsScreen.dart';
import 'package:flutter/material.dart';
import 'screens/CreatePostScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/SignInScreen.dart';
import 'screens/SignUpScreen.dart';
import 'screens/PostScreen.dart';
import 'screens/ProfileScreen.dart';
import 'screens/ProfileEditScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake To Nahin',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'SignIn',
      routes: {
        'SignIn': (context) => SignInScreen(),
        'SignUp': (context) => SignUpScreen(),
        'Home': (context) => HomeScreen(),
        'CreatePost': (context) => CreatePostScreen(),
        'Profile': (context) => ProfileScreen(),
        'ProfileEdit': (context) => ProfileEditScreen(),
        'Post': (context) => PostScreen(),
        'MyPosts': (context) => MyPostsScreen(),
        'SavedPosts': (context) => SavedPostsScreen(),
      },
    );
  }
}
