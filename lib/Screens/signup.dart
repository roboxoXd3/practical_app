import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practical_app/Style/DecorationStyle.dart';
import 'package:validators/validators.dart' as validator;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                    child: Container(
                      child: Text(
                        "Register",
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
                        horizontal: 16.0, vertical: 24.0),
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

                        RegisterWithEmail().whenComplete(
                            () => Navigator.pushNamed(context, 'login'));
                      }
                    },
                    child: Text("Register"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: Text("Already have an Account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> RegisterWithEmail() async {
    _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .catchError((Error) {
      PlatformException error = Error;
      signupError = error.toString();
      print(signupError);
    });
    //     .then((user) async {
    //   if (user != null) {
    //     final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    //
    //     ///ye important hai babu
    //     final QuerySnapshot result = await Firestore.instance
    //         .collection('users')
    //         .where("id", isEqualTo: currentUser.uid)
    //         .getDocuments();
    //
    //     final List<DocumentSnapshot> document = result.documents;
    //
    //     if (document.length == 0) {
    //       Firestore.instance
    //           .collection('users')
    //           .document(currentUser.uid)
    //           .setData({
    //         "Email": currentUser.email,
    //         // "number": Number,
    //       });
    //     }
    //
    //     Navigator.pushNamed(context, 'login');
    //   }
    // });
  }
}
