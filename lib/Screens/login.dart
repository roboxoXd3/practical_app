import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_app/Screens/ContactsPage.dart';
import 'package:practical_app/Style/DecorationStyle.dart';
import 'package:validators/validators.dart' as validator;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email;
  final _formKey = GlobalKey<FormState>();
  String password;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var signupError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    child: Container(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 50, color: Colors.indigo),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    child: Container(
                      decoration: kContainerDecoration,
                      width: MediaQuery.of(context).size.width,
                      // height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                          validator: (String email) {
                            if (!validator.isEmail(email)) {
                              return "Enter a valid mail";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    child: Container(
                      decoration: kContainerDecoration,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                          validator: (String password) {
                            if (password.length < 5) {
                              return "Password length must be greater than 5";
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          _firebaseAuth
                              .signInWithEmailAndPassword(
                                  email: email, password: password)
                              .catchError((e) {
                            print(e);
                          }).then((user) {
                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactsPage()),
                              );
                            } else if (user == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactsPage()),
                              );
                            }
                          });
                        }
                      }
                    },
                    child: Text("Login"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'signup');
                    },
                    child: Text("Don't Have an Account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
