// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:auth_demo/models/tasks.dart';

class AuthService {
  final String uid;
  final String docid;
  AuthService({this.uid, this.docid});
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      Firestore.instance.collection("users");
  final CollectionReference _taskCollection =
      Firestore.instance.collection("Tasks");

  Map<String, String> errorMessage = {
    "email": "",
    "password": "",
    "network": "",
  };

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // print(doc.data);
      print(doc.data);
      return Task(
        documentuid: doc.documentID,
        title: doc.data['Course'] ?? '',
        subtitle: doc.data['Lecturer'] ?? '',
        startTime: doc.data['Starting time'] ?? '',
        venue: doc.data['Venue'] ?? '',
        currentFilled: doc.data['Currently Filled'] ?? 0,
        offline: doc.data['offline'] ?? false,
        //map
        mp: doc.data['mp'] ?? {},
      );
    }).toList();
  }

  // List<dynamic> get listBool{
  //   List<dynamic> mylist;
  //   String email;
  //   print("userid is ${this.uid}");
  //    _usersCollection.document(this.uid).get().then((DocumentSnapshot documentSnapshot){
  //     if(documentSnapshot.exists){
  //       print('document exists on databse data is ${documentSnapshot.data}');
  //       mylist = documentSnapshot.data['tasksBoolean'];
  //       print(mylist);
  //       return  mylist;
  //     }
  //     else{
  //       print('document does not exist');
  //     }
  //   }
  //   );
  //   print(mylist);
  //   return mylist;
  //   //return _taskPerUser.snapshots().map(_taskListFromSnapshot);
  // }

  List<DocumentReference> get tasksPerUSer {
    List<DocumentReference> mylist;
    String email;
    _usersCollection
        .document(this.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('document exists on databse data is ${documentSnapshot.data}');
        mylist = documentSnapshot.data['tasks'];
      } else {
        print('document does not exist');
      }
    });
    return mylist;
    //return _taskPerUser.snapshots().map(_taskListFromSnapshot);
  }

  Stream<List<Task>> get tasks {
    return _taskCollection.snapshots().map(_taskListFromSnapshot);
  }

  Stream<List<Task>> get tasks2 {
    final Query _taskCollection2 = Firestore.instance
        .collection("Tasks")
        .where('Author', isEqualTo: uid.toString());
    return _taskCollection2.snapshots().map(_taskListFromSnapshot);
  }

  // User State
  Stream<FirebaseUser> authStateChanges() {
    FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
    return _firebaseInstance.onAuthStateChanged;
  }

  // Current User
  Future<FirebaseUser> currentUser() async {
    FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
    return _firebaseInstance.currentUser();
  }

  Future currentUserFirestore(String userid) async {
    return _taskCollection.document(userid);
  }

  Future<void> signOut() async {
    FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
    return _firebaseInstance.signOut();
  }

  Future<void> updateTask(String name, int strength, bool offline) async {
    return await _taskCollection.document(docid).updateData({
      'Currently Filled': strength,
      'mp': {
        this.uid.toString(): offline,
      }
      // 'taskBoolList' : FieldValue.arrayUnion({name});
      // 'List of users' : FieldValue.arrayUnion({})
    });
  }

  Future<void> deleteTaskUser(int strength) async {
    String useridstring = this.uid.toString();
    return await _taskCollection.document(docid).updateData({
      'Currently Filled': strength,
      'mp.${useridstring}': FieldValue.delete(),
      // 'taskBoolList' : FieldValue.arrayUnion({name});
      // 'List of users' : FieldValue.arrayUnion({})
    });
  }

  Future<void> deleteTaskUserOffline(int strength) async {
    String useridstring = this.uid.toString();
    return await _taskCollection.document(docid).updateData({
      'Currently Filled': strength,
      'mp.${useridstring}': false,
      // 'taskBoolList' : FieldValue.arrayUnion({name});
      // 'List of users' : FieldValue.arrayUnion({})
    });
  }
  //   Future<void> deleteTaskUser() async {
  //   return await _taskCollection.document(docid).updateData({
  //     'Currently Filled': strength,
  //     'mp': {
  //       this.uid.toString(): offline,
  //     }
  //     // 'taskBoolList' : FieldValue.arrayUnion({name});
  //     // 'List of users' : FieldValue.arrayUnion({})
  //   });
  // }

  Future<void> addUserToTask() async {
    String useridstring = this.uid.toString();
    return await _taskCollection
        .document(docid)
        .updateData({'mp.${useridstring}': false});
  }

  Future<void> deleteTask() async {
    return await _taskCollection.document(docid).delete();
  }

  Future<void> addTask(String course, String lecturer, List<bool> repeat,
      String startingtime, String venue) async {
    _taskCollection.add({
      "Course": course,
      "Lecturer": lecturer,
      "Repeat": repeat,
      "Starting time": startingtime,
      "Venue": venue,
      "Currently Filled": 0,
      "Max Capacity": 10,
      "offline": false,
      'mp': {},
      'Author': uid.toString(),
    });
  }

  void _changePassword(String password) async {
    //Create an instance of the current user.
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<void> updateProfile(
      String name, String password, int vaccinationStatus) async {
    if (password.isNotEmpty) _changePassword(password);
    return await _usersCollection.document(this.uid.toString()).updateData({
      'name': name,
      'Vaccine': vaccinationStatus,
      // 'taskBoolList' : FieldValue.arrayUnion({name});
      // 'List of users' : FieldValue.arrayUnion({})
    });
  }

  // Reset Password
  Future<Map<String, String>> forgotPassword(String email) async {
    try {
      await _firebaseInstance.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      if (error.message ==
          "An internal error has occurred. [ Unable to resolve host \"www.googleapis.com\":No address associated with hostname ]") {
        errorMessage["network"] = "No internet connection. Try again!";
      }

      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          print("ERROR_INVALID_EMAIL");
          errorMessage["email"] = "Invalid email";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          print("ERROR_NETWORK_REQUEST_FAILED");
          errorMessage["email"] = "No internet connection. Try again!";
          break;
      }
    }
    return errorMessage;
  }

  // Sign In With Email And Password
  Future<Map<String, String>> signIn(String email, String password) async {
    try {
      await _firebaseInstance.signInWithEmailAndPassword(
          email: email, password: password);
    } on PlatformException catch (error) {
      if (error.message ==
          "An internal error has occurred. [ Unable to resolve host \"www.googleapis.com\":No address associated with hostname ]") {
        errorMessage["network"] = "No internet connection. Try again!";
      }
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          print("ERROR_INVALID_EMAIL");
          errorMessage["email"] = "Invalid email";
          break;
        case "ERROR_WRONG_PASSWORD":
          print("ERROR_WRONG_PASSWORD");
          errorMessage["password"] = "Wrong password";
          break;
        case "ERROR_USER_NOT_FOUND":
          print("ERROR_USER_NOT_FOUND");
          errorMessage["email"] = "Email not registered. Please sign up!";
          break;
        case "ERROR_USER_DISABLED":
          print("ERROR_USER_DISABLED");
          errorMessage["email"] = "This user has been disabled";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          print("ERROR_TOO_MANY_REQUESTS");
          errorMessage["email"] = "Too many requests. Try again later!";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          print("ERROR_NETWORK_REQUEST_FAILED");
          errorMessage["network"] = "No internet connection. Try again!";
          break;
      }
    }
    return errorMessage;
  }

  // Create User With Email And Password
  Future<Map<String, String>> signUp(
      String email, String password, String name, int value) async {
    try {
      await _firebaseInstance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        if (user != null) {
          // Save User Information To Database
          _usersCollection.document(user.user.uid).setData(
            {
              "email": user.user.email,
              "uid": user.user.uid,
              "tasks": [],
              "tasksBoolean": [],
              "name": name,
              "role": value,
              'Vaccine': 1,
            },
          );
          return Null;
        } else {
          return Null;
        }
      });
      // await authResult.user.updateProfile(displayName : name);
    } on PlatformException catch (error) {
      if (error.message ==
          "An internal error has occurred. [ Unable to resolve host \"www.googleapis.com\":No address associated with hostname ]") {
        errorMessage["network"] = "No internet connection. Try again!";

        switch (error.code) {
          case "ERROR_INVALID_EMAIL":
            print("ERROR_INVALID_EMAIL");
            errorMessage["email"] = "Invalid email";
            break;
          case "ERROR_WEAK_PASSWORD":
            print("ERROR_WEAK_PASSWORD");
            errorMessage["email"] =
                "Password should be at least 6 characters long";
            break;
          case "ERROR_EMAIL_ALREADY_IN_USE":
            print("ERROR_EMAIL_ALREADY_IN_USE");
            errorMessage["email"] = "Email already in use. Please log in!";
            break;
        }
      }
    }
    return errorMessage;
  }
}
