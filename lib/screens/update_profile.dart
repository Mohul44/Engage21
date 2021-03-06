import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:engage_scheduler/widgets/top_container.dart';
import 'package:engage_scheduler/widgets/back_button.dart';
import 'package:engage_scheduler/widgets/my_text_field.dart';
import 'package:engage_scheduler/screens/home_page.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';

import '../authService.dart';

class UpdateProfile extends StatefulWidget {
  final String userid;
  const UpdateProfile(this.userid);
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<UpdateProfile> {
  TextEditingController Course = new TextEditingController();
  TextEditingController Lecturer = new TextEditingController();
  TextEditingController StartingTime = new TextEditingController();
  TextEditingController Venue = new TextEditingController();
  GlobalKey<FormState> _addTaskFormKey = GlobalKey<FormState>();
  int group1Value = 2;
  List<bool> mylist = [false, true, false, true, false, true, false];
  bool isDocumentUploaded = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(widget.userid)
              .snapshots(),
          builder: (context, snapshot) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TopContainer(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    width: width,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            MyBackButton(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                            ),
                            Text(
                              'update profile',
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Form(
                            key: _addTaskFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: Course,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.name,
                                  cursorColor: Theme.of(context).accentColor,
                                  obscureText: false,
                                  style: Theme.of(context).textTheme.headline5,
                                  decoration:
                                      InputDecoration(labelText: "Name"),
                                  validator: (name) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: StartingTime,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.name,
                                  cursorColor: Theme.of(context).accentColor,
                                  obscureText: true,
                                  style: Theme.of(context).textTheme.headline5,
                                  decoration:
                                      InputDecoration(labelText: "Password"),
                                  validator: (name) {
                                    return null;
                                  },
                                ),
                                SizedBox(width: 40),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: Venue,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.name,
                                  cursorColor: Theme.of(context).accentColor,
                                  obscureText: true,
                                  style: Theme.of(context).textTheme.headline5,
                                  decoration: InputDecoration(
                                      labelText: "Rewrite Password"),
                                  validator: (name) {
                                    if (Venue.text != StartingTime.text) {
                                      return "Password does not match";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  //   child: Text(
                  //     'Vaccination status',
                  //     style: TextStyle(
                  //         fontSize: 30.0, fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: group1Value,
                                onChanged: (value) {
                                  setState(() {
                                    group1Value = value;
                                  });
                                },
                              ),
                              Expanded(child: Text("not vaccinated")),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: group1Value,
                                onChanged: (value) {
                                  setState(() {
                                    group1Value = value;
                                  });
                                },
                              ),
                              Expanded(child: Text("partially vaccinated")),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Radio(
                                value: 3,
                                groupValue: group1Value,
                                onChanged: (value) {
                                  setState(() {
                                    group1Value = value;
                                  });
                                },
                              ),
                              Expanded(child: Text("completely vaccinated")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("vaccination certificate",
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                            ),
                            label: Text("Add file"),
                            icon: Icon(
                              Icons.upload,
                              size: 20.0,
                              color: LightColors.kDarkBlue,
                            ),
                            onPressed: () async {
                              setState(() {
                                isDocumentUploaded = true;
                              });
                              await AuthService(uid: widget.userid)
                                  .pickFile()
                                  .then((value) => {
                                        isDocumentUploaded = true,
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     // return object of type Dialog
                                        //     return AlertDialog(
                                        //       backgroundColor:
                                        //           LightColors.kDarkBlue,
                                        //       title: new Text(
                                        //           "Document uploaded successfully"),
                                        //       content: new Text(
                                        //         "You can update yor profile as completely vaccinated now",
                                        //         style: TextStyle(
                                        //             color: Colors.white70),
                                        //       ),
                                        //       actions: <Widget>[
                                        //         // usually buttons at the bottom of the dialog
                                        //         new FlatButton(
                                        //           child: new Text("Close"),
                                        //           onPressed: () {
                                        //             Navigator.of(context).pop();
                                        //           },
                                        //         ),
                                        //       ],
                                        //     );
                                        //   },
                                        // ),
                                      });
                            }),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(2, 10, 2, 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                        ),
                        child: Text(
                          'update Profile',
                          style: TextStyle(
                              fontSize: 15,
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (_addTaskFormKey.currentState.validate()) {
                            if (Course.text.isEmpty)
                              Course.text = snapshot.data['name'];
                            if (group1Value == 3 &&
                                isDocumentUploaded == false) {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     // return object of type Dialog
                              //     return AlertDialog(
                              //       backgroundColor: LightColors.kDarkBlue,
                              //       title: new Text("Document not uploaded"),
                              //       content: new Text(
                              //         "To be marked as completely vaccinated you need to upload vaccination certificate",
                              //         style: TextStyle(color: Colors.white70),
                              //       ),
                              //       actions: <Widget>[
                              //         // usually buttons at the bottom of the dialog
                              //         new FlatButton(
                              //           child: new Text("Close"),
                              //           onPressed: () {
                              //             Navigator.of(context).pop();
                              //           },
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                            } else {
                              await AuthService(uid: widget.userid)
                                  .updateProfile(
                                      Course.text, Venue.text, group1Value);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    backgroundColor: LightColors.kDarkBlue,
                                    title: new Text("Profile updated"),
                                    content: new Text(
                                      "Profile updated with given information",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        }),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  // Container(
                  //   height: 120,
                  //   width: width,
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: <Widget>[
                  //       Container(
                  //         child: ElevatedButton(
                  //             child: Text(
                  //               'View certificate',
                  //               style: TextStyle(
                  //                   fontSize: 20, color: LightColors.kDarkBlue),
                  //             ),
                  //             onPressed: () async {}),
                  //         alignment: Alignment.center,
                  //         margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  //         width: width - 40,
                  //         decoration: BoxDecoration(
                  //           color: Colors.transparent,
                  //           borderRadius: BorderRadius.circular(30),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          }),
    );
  }
}
