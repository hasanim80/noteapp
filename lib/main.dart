import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/login.dart';
import 'package:noteapp/app/auth/signup.dart';
import 'package:noteapp/app/auth/success.dart';
import 'package:noteapp/app/home.dart';
import 'package:noteapp/app/notes/add.dart';
import 'package:noteapp/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences
      .getInstance(); // to access shared preferences from any where in app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'course PHP Rest API',
      initialRoute: sharedPref.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": (context) => Success(),
        "addnotes": (context) => AddNotes(),
        "editnotes": (context) => EditNotes()
      },
    );
  }
}
