import 'package:flutter/material.dart';

import 'package:practical_app/Screens/login.dart';
import 'package:practical_app/Screens/signup.dart';

import 'Screens/ContactsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'signup',
      routes: {
        'signup': (context) => SignUp(),
        'login': (context) => Login(),
        'homepage': (context) => ContactsPage(),
      },
    );
  }
}
