import 'package:engage_scheduler/authService.dart';
import 'package:engage_scheduler/screens/add_task_home.dart';
import 'package:engage_scheduler/screens/mark_attendance.dart';
import 'package:engage_scheduler/screens/show_list.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveProjectCard extends StatefulWidget {
  Color cardColor;
  double loadingPercent;
  String title;
  String subtitle;
  int capacity;
  int currentFilled;
  String startTime;
  bool offline;
  String docid;
  String userid;
  int length;
  String venue;
  List<dynamic> mylist;
  int vaccineReq;
  ActiveProjectCard(
      {this.cardColor,
      this.loadingPercent,
      this.title,
      this.subtitle,
      this.capacity,
      this.currentFilled,
      this.startTime,
      this.offline,
      this.docid,
      this.userid,
      this.length,
      this.venue,
      this.mylist,
      this.vaccineReq});

  @override
  _ActiveProjectsCard createState() => _ActiveProjectsCard();
}

class _ActiveProjectsCard extends State<ActiveProjectCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    print("screeen3 ${screenHeight}");
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
            decoration: BoxDecoration(
              color: widget.cardColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18.0 / 683.4 * screenHeight,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5 / 683.4 * screenHeight,
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 12.0 / 683.4 * screenHeight,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "IST ${widget.startTime}:00   ${widget.venue}",
                      style: TextStyle(
                        fontSize: 12.0 / 683.4 * screenHeight,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Days: ", style: TextStyle(color: Colors.white60)),
                        widget.mylist[0] == true
                            ? Text(
                                "Su ",
                                style: TextStyle(color: Colors.white60),
                              )
                            : Text(""),
                        widget.mylist[1] == true
                            ? Text("Mo ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[2] == true
                            ? Text("Tu ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[3] == true
                            ? Text("We ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[4] == true
                            ? Text("Th ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[5] == true
                            ? Text("Fi ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[6] == true
                            ? Text("Sa ",
                                style: TextStyle(color: Colors.white54))
                            : Text(""),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Students enrolled " + widget.length.toString(),
                      style: TextStyle(
                        fontSize: 14.0 / 683.4 * screenHeight,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Seats reserved " +
                          widget.currentFilled.toString() +
                          "/" +
                          widget.capacity.toString(),
                      style: TextStyle(
                        fontSize: 14.0 / 683.4 * screenHeight,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Vacc req:  ${widget.vaccineReq == 1 ? "Not required" : widget.vaccineReq == 2 ? "Partial" : "Complete"}",
                      style: TextStyle(
                        fontSize: (14.0 / 683.4 * screenHeight),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5 / 683.4 * screenHeight,
                    ),
                    ActionChip(
                      backgroundColor: Colors.white70,
                      label: Container(
                        alignment: Alignment.center,
                        width: 110,
                        height: 20,
                        child: Text(
                          "Student list",
                          style: TextStyle(
                              color: widget.cardColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowList(widget.docid,
                                widget.currentFilled, widget.offline),
                          ),
                        )
                      },
                    ),
                    ActionChip(
                      backgroundColor: Colors.white70,
                      label: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 110,
                        child: Text(
                          "Mark attendance",
                          style: TextStyle(
                              color: widget.cardColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarkAttendance(widget.docid,
                                widget.currentFilled, widget.offline),
                          ),
                        )
                      },
                    ),
                    ActionChip(
                      backgroundColor: Colors.white70,
                      label: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 110,
                        child: Text(
                          "Delete lecture",
                          style: TextStyle(
                              color: widget.cardColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              backgroundColor: widget.cardColor,
                              title: new Text("Delete lecture"),
                              content: new Text(
                                "Deleting this lecture would remove this from everyone's schedule !",
                                style: TextStyle(color: Colors.white70),
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Yes"),
                                  onPressed: () {
                                    if (this.mounted)
                                      setState(() {
                                        AuthService(
                                                uid: widget.userid,
                                                docid: widget.docid)
                                            .deleteTask();
                                      });
                                    Navigator.pop(context);
                                  },
                                ),
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
