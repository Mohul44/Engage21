// ignore_for_file: unnecessary_brace_in_string_interps
import 'dart:io';
import 'package:engage_scheduler/dates_list.dart' as global;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:engage_scheduler/models/tasks.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:engage_scheduler/utilities.dart' as global;

class AuthService {
  final String uid;
  final String docid;
  AuthService({this.uid, this.docid});
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      Firestore.instance.collection("users");
  final CollectionReference _taskCollection =
      Firestore.instance.collection("Tasks");
  FirebaseStorage _storage = FirebaseStorage.instance;
  int total_lectures = 0;
  int attendance = 1;
  int user_attendance;
  Map<String, String> errorMessage = {
    "email": "",
    "password": "",
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
        link: doc.data['Link'] ?? "",
        vaccine: doc.data['Vaccine'] ?? 2,
        mp: doc.data['mp'] ?? {},
        mp2: doc.data['mp2'] ?? {},
      );
    }).toList();
  }

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

  String getFilePath() {
    return "gs://engagescheduler-e71b5.appspot.com/vaccine_certificates/${this.uid.toString()}";
  }

  // Future<void> viewPdf() async{
  //   await FileP
  // }

  Future<void> signOut() async {
    FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
    return _firebaseInstance.signOut();
  }

  Future<void> pickFile() async {
    try {
      StorageReference reference =
          _storage.ref().child("vaccine_certificates/${uid.toString()}");
      File file = await FilePicker.getFile(type: FileType.custom);
      StorageUploadTask uploadTask = reference.putFile(file);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      final String url = (await taskSnapshot.ref.getDownloadURL());
      print('URL Is $url');
      await _usersCollection.document(uid.toString()).updateData({
        'downloadURL': url,
      });
    } catch (e) {}
    // final path = FlutterDocumentPicker.openDocument();
    //print("paaaaath is ${path.toString()}");
  }

  Future<void> updateTask(String name, int strength, bool offline) async {
    String useridstring = this.uid.toString();
    return await _taskCollection.document(docid).updateData({
      'Currently Filled': strength,
      'mp.${useridstring}': offline,
    });
  }

  // Future<void> updateTaskAttendance(int inc) async {
  //   String useridstring = this.uid.toString();
  //   await getAttendanceUser();
  //   return await _taskCollection.document(docid).updateData({
  //     'mp2.${useridstring}': inc + user_attendance,
  //   });
  // }

  Future<void> updateAttendance(List<bool> mylist) async {
    DocumentSnapshot ds = await _taskCollection.document(docid).get();
    await getAttendance();
    int ind = 0;
    await _taskCollection.document(docid).updateData({
      'Attendance': (attendance + 1),
    });
    for (String k in ds.data['mp2'].keys) {
      int inc = mylist[ind++] == true ? 1 : 0;
      user_attendance = await ds.data['mp2'][k];
      await _taskCollection.document(docid).updateData({
        'mp2.${k}': inc + user_attendance,
      });
    }
  }

  Future<void> deleteTaskUser(int strength) async {
    String useridstring = this.uid.toString();
    await getTotalLectures();
    await _taskCollection.document(docid).updateData({
      'Currently Filled': strength,
      'mp.${useridstring}': FieldValue.delete(),
      'mp2.${useridstring}': FieldValue.delete(),
    });
    await _usersCollection.document(useridstring).updateData({
      'Total Lectures': (total_lectures - 1),
    });
  }

  Future<void> deleteTaskUserOffline(int strength) async {
    String useridstring = this.uid.toString();

    return await _taskCollection.document(docid).updateData({
      'Currently Filled': strength,
      'mp.${useridstring}': false,
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
    await getTotalLectures();
    String useridstring = this.uid.toString();
    await _taskCollection
        .document(docid)
        .updateData({'mp.${useridstring}': false, 'mp2.${useridstring}': 0});
    await _usersCollection.document(useridstring).updateData({
      'Total Lectures': total_lectures + 1,
    });
  }

  Future<void> deleteTask() async {
    DocumentSnapshot ds = await _taskCollection.document(docid).get();
    DocumentSnapshot ds2;
    String startingtime = ds.data['Starting time'];
    int start = int.parse(startingtime) - 8;
    if (start < 0) start += 12;
    List<dynamic> repeat = ds.data['Repeat'];
    for (var i = 0; i < 7; i++) {
      if (repeat[i] == true) {
        global.twoDList[i][start][0] = "";
        global.twoDList[i][start][1] = "";
        global.twoDList[i][start][2] = "";
      }
    }
    for (var k in ds.data['mp'].keys) {
      ds2 = await _usersCollection.document(k.toString()).get();
      int total_lectures2 = ds2.data['Total Lectures'];
      await _usersCollection.document(k.toString()).updateData({
        'Total Lectures': total_lectures2 - 1,
      });
    }
    await getTotalLectures();
    await _usersCollection.document(uid.toString()).updateData({
      'Total Lectures': total_lectures - 1,
    });
    return await _taskCollection.document(docid).delete();
  }

  Future<void> updateCalendar() async {
    Firestore.instance.collection("Tasks").snapshots().listen((snapshot) {
      List<dynamic> rep;
      String course;
      String venue;
      String startingTime;
      int timeInd;
      String lecturer;
      snapshot.documents.forEach((ds) {
        rep = ds.data['Repeat'];
        course = ds.data['Course'];
        venue = ds.data['Venue'];
        lecturer = ds.data['Lecturer'];
        startingTime = ds.data['Starting time'];
        timeInd = int.parse(startingTime) - 8;
        for (var i = 0; i < 7; i++) {
          if (rep[i] == true) {
            global.twoDList[i][timeInd][0] = course;
            global.twoDList[i][timeInd][1] = venue;
            global.twoDList[i][timeInd][2] = lecturer;
          }
        }
      });
    });
  }

  Future<void> addTask(
      String course,
      String lecturer,
      List<bool> repeat,
      String startingtime,
      String venue,
      String onlineMeetLink,
      int vaccineReq) async {
    int start = int.parse(startingtime) - 8;
    print("starting time ${startingtime}");
    if (start < 0) start += 12;
    print(start);
    for (var i = 0; i < 7; i++) {
      if (repeat[i] == true) {
        if (global.twoDList[i][start][0].toString().isNotEmpty) {
          print("cannot add task, clash");
          return Future.error("error");
        }
      }
    }
    for (var i = 0; i < 7; i++) {
      if (global.twoDList[i][start][0].toString().isEmpty) {
        if (repeat[i] == true) {
          global.twoDList[i][start][0] = course;
          global.twoDList[i][start][1] = lecturer;
          global.twoDList[i][start][2] = venue;
        }
      }
    }
    await getTotalLectures();
    await _usersCollection.document(uid.toString()).updateData({
      'Total Lectures': total_lectures + 1,
    });
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
      'mp2': {},
      'Author': uid.toString(),
      'Link': onlineMeetLink.toString(),
      'Vaccine': vaccineReq,
      "Attendance": 0,
    });
    updateCalendar();
  }

  Future<void> getTotalLectures() async {
    DocumentSnapshot ds =
        await _usersCollection.document(this.uid.toString()).get();
    total_lectures = ds.data['Total Lectures'];
  }

  Future<void> getAttendance() async {
    DocumentSnapshot ds =
        await _taskCollection.document(this.docid.toString()).get();
    print(ds.data);
    attendance = ds.data['Attendance'];
    print(attendance);
  }

  // Future<void> getAttendanceUser() async {
  //   DocumentSnapshot ds =
  //       await _taskCollection.document(this.docid.toString()).get();
  //   user_attendance = ds.data['mp2'][this.uid.toString()];
  // }

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
      }
    }
    return errorMessage;
  }

  // Create User With Email And Password
  Future<Map<String, String>> signUp(
      String email, String password, String name, int value) async {
    try {
      print("here 3");
      await _firebaseInstance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        print("here 4");
        if (user != null) {
          print("here 5");
          // Save User Information To Database
          print(email);
          _usersCollection.document(user.user.uid).setData(
            {
              "email": user.user.email,
              "uid": user.user.uid,
              "name": name,
              "role": value,
              'Vaccine': 1,
              'Total Lectures': 0,
              'Total lectures per day': [],
              'downloadURL': ""
            },
          );
          print(1);
          return Null;
        } else {
          print("unable to register user with the given mail");
          return Null;
        }
      });
      // await authResult.user.updateProfile(displayName : name);
    } on PlatformException catch (error) {
      print("hereeeeeeee ${error}");
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
