import 'package:auth_demo/authService.dart';
import 'package:auth_demo/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_demo/screens/home_page.dart';
import 'package:auth_demo/screens/teachers_home_page.dart';

class Initializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: AuthService().authStateChanges(),
      builder: (context, AsyncSnapshot snapshot) {
        // if the stream has data, the user is logged in
        if (snapshot.hasData) {
          final String userid = snapshot.data.uid;
          // isLoggedIn

          return StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot2) {
                if (!snapshot2.hasData) {
                  return new Text(
                    "Loading",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                print("ATTnton                                       ");
                int role = snapshot2.data['role'];
                if (role == 2) return TeacherHomePage();
                return HomePage();
              });
        } else if (snapshot.hasData == false &&
            snapshot.connectionState == ConnectionState.active) {
          // isLoggedOut
          return Authentication();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
