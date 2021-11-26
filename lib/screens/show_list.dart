import 'package:engage_scheduler/models/tasks.dart';
import 'package:engage_scheduler/widgets/back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:engage_scheduler/screens/calendar_page.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:engage_scheduler/widgets/task_column.dart';
import 'package:engage_scheduler/widgets/active_project_card.dart';
import 'package:engage_scheduler/widgets/top_container.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:engage_scheduler/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'tasks_list.dart';
import 'package:engage_scheduler/models/tasks.dart';

class ShowList extends StatefulWidget {
  final String taskid;
  final int currentFilled;
  final bool offline;
  const ShowList(this.taskid, this.currentFilled, this.offline);
  @override
  _ShowList createState() => _ShowList();
}

class _ShowList extends State<ShowList> {
  List<Color> myColors = [
    LightColors.kBlue,
    LightColors.kRed,
    LightColors.kGreen,
    LightColors.kLightYellow2,
  ];
  String _url =
      "https://firebasestorage.googleapis.com/v0/b/engagescheduler-e71b5.appspot.com/o/vaccine_certificates%2FecW1hycM2WgAe0tOtx8wARCk0WI2?alt=media&token=ec3f098f-fb0a-448e-81b2-a6f731a47e2a";
  void _launchURL(String _url2) async {
    if (!await launch(_url2)) throw 'Could not launch $_url2';
  }

  List<String> mylist = ["offline", "Online", "All"];
  String dropDownValue = "offline";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightColors.kDarkBlue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 0, 40),
                    child: MyBackButton()),
                Expanded(
                  child: Text(
                    "Double Tap to remove students from offline class",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, color: LightColors.kLavender),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              alignment: Alignment.center,
              child: DropdownButton(
                dropdownColor: LightColors.kGreen,
                value: dropDownValue,
                style: new TextStyle(
                  color: Colors.white,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                items: mylist.map((items) {
                  return DropdownMenuItem(
                      value: items.toString(),
                      child: Text(
                        "${items}",
                        style: TextStyle(fontSize: 20),
                      ));
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: Firestore.instance
                    .collection('Tasks')
                    .document(widget.taskid.toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text(
                      "Loading",
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data['mp'].length,
                        itemBuilder: (BuildContext context, int index) {
                          String key =
                              snapshot.data['mp'].keys.elementAt(index);
                          bool value = snapshot.data['mp'][key];
                          if (dropDownValue == "All") {
                            value = true;
                          }
                          if (dropDownValue == "Online") {
                            value = !value;
                          }
                          return StreamBuilder(
                              stream: Firestore.instance
                                  .collection('users')
                                  .document(key)
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
                                if (value == true) {
                                  return GestureDetector(
                                    onTap: () {
                                      String url2 = _url;
                                      if (snapshot2.data['downloadURL']
                                          .toString()
                                          .isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              backgroundColor:
                                                  LightColors.kDarkBlue,
                                              title: new Text(
                                                  "Vaccine certificate not found"),
                                              content: new Text(
                                                "Double tap the student name to remove the sutdent from offline class+",
                                                style: TextStyle(
                                                    color: Colors.white70),
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
                                      } else {
                                        url2 = snapshot2.data['downloadURL']
                                            .toString();
                                        _launchURL(url2);
                                      }
                                    },
                                    onDoubleTap: () {
                                      if (this.mounted)
                                        setState(() {
                                          int currentFilled =
                                              widget.currentFilled;
                                          AuthService(
                                                  uid: key.toString(),
                                                  docid: widget.taskid)
                                              .deleteTaskUserOffline(
                                                  currentFilled - 1);
                                        });
                                    },
                                    child: new ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      tileColor:
                                          myColors[index % myColors.length],
                                      title: new Text(
                                        "${snapshot2.data['name']}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: LightColors.kLavender,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                } else
                                  return Container();
                              });
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
