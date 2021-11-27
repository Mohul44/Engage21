import 'package:engage_scheduler/authService.dart';
import 'package:engage_scheduler/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage_scheduler/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:engage_scheduler/screens/home_page.dart';
import 'package:engage_scheduler/screens/teachers_home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//initializing screen to check if a user is logged in, logged out and call appropriate page

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
                  return Loader();
                }
                print(snapshot2.data);
                int role;
                try {
                  role = snapshot2.data['role'] ?? 1;
                } catch (e) {
                  role = 1;
                }
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
