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

class MarkAttendance extends StatefulWidget {
  final String taskid;
  final int currentFilled;
  final bool offline;
  const MarkAttendance(this.taskid, this.currentFilled, this.offline);
  @override
  _ShowList createState() => _ShowList();
}

class _ShowList extends State<MarkAttendance> {
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
  int markAttendance = 0;
  List<bool> toggle = List.filled(
    10,
    false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightColors.kDarkBlue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    "View or record attendance",
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
                        itemCount: snapshot.data['mp2'].length,
                        itemBuilder: (BuildContext context, int index) {
                          String key =
                              snapshot.data['mp2'].keys.elementAt(index);
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

                                double attendance =
                                    snapshot.data['mp2'][key] != 0
                                        ? (snapshot.data['mp2'][key] /
                                                snapshot.data['Attendance']) *
                                            100
                                        : 0.0;
                                if (true) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(vertical: 0.0),
                                    padding: EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: myColors[index % myColors.length],
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "${snapshot2.data['name']}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: LightColors.kLavender,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        markAttendance == 1
                                            ? Switch(
                                                value: toggle[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    toggle[index] = value;
                                                  });
                                                })
                                            : CircularPercentIndicator(
                                                radius: 60.0,
                                                lineWidth: 5.0,
                                                animation: true,
                                                percent: attendance / 100,
                                                center: Text(
                                                  attendance
                                                          .toStringAsFixed(0) +
                                                      "%",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: LightColors
                                                          .kLavender),
                                                ),
                                                backgroundColor: Colors.grey,
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                progressColor:
                                                    LightColors.kLavender,
                                              )
                                      ],
                                    ),
                                  );
                                }
                              });
                        },
                      ),
                    ),
                  );
                }),
            Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                  ),
                  child: Text(
                    markAttendance == 0
                        ? 'Record attendance'
                        : markAttendance == 1
                            ? "Done"
                            : "Attendance Taken",
                    style: TextStyle(
                        fontSize: 15,
                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (this.mounted)
                      setState(() {
                        markAttendance++;
                        if (markAttendance == 2) {
                          AuthService(docid: widget.taskid.toString())
                              .updateAttendance(toggle);
                        }
                      });
                  }),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 40),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
