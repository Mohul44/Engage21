import 'package:auth_demo/models/tasks.dart';
import 'package:auth_demo/widgets/back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auth_demo/screens/calendar_page.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:auth_demo/widgets/task_column.dart';
import 'package:auth_demo/widgets/active_project_card.dart';
import 'package:auth_demo/widgets/top_container.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:auth_demo/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'tasks_list.dart';
import 'package:auth_demo/models/tasks.dart';

class ShowList extends StatefulWidget {
  final String taskid;
  const ShowList(this.taskid);
  @override
  _ShowList createState() => _ShowList();
}

class _ShowList extends State<ShowList> {
  List<Color> myColors = [
    LightColors.kLavender,
    LightColors.kLightYellow,
    LightColors.kPalePink,
    LightColors.kLightYellow2,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightColors.kBlue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
                    child: MyBackButton()),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    "Tap to remove students",
                    style:
                        TextStyle(fontSize: 25, color: LightColors.kLavender),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
                                return GestureDetector(
                                  onTap: () {
                                    if (this.mounted)
                                      setState(() {
                                        // AuthService(uid: key.toString(), docid: widget.taskid)
                                        //     .deleteTaskUser();
                                      });
                                  },
                                  child: new ListTile(
                                    tileColor:
                                        myColors[index % myColors.length],
                                    title: new Text(
                                      "${snapshot2.data['name']}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: LightColors.kDarkBlue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
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
