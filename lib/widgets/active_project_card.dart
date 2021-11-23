import 'package:engage_scheduler/authService.dart';
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
  int vaccine;
  ActiveProjectCard({
    this.cardColor,
    this.loadingPercent,
    this.title,
    this.subtitle,
    this.capacity,
    this.currentFilled,
    this.startTime,
    this.offline,
    this.docid,
    this.userid,
    this.vaccine,
  });

  @override
  _ActiveProjectsCard createState() => _ActiveProjectsCard();
}

class _ActiveProjectsCard extends State<ActiveProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.44,
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: widget.cardColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "IST ${widget.startTime}:00",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Max Capacity  " + widget.capacity.toString(),
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Currently filled  " + widget.currentFilled.toString(),
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Attend offline",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Switch(
                          value: widget.offline,
                          onChanged: (value) {
                            int strength = widget.currentFilled;
                            if (widget.vaccine == 1) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    backgroundColor: LightColors.kDarkBlue,
                                    title: new Text("Not vaccinated"),
                                    content: new Text(
                                      "Students who are not even partially vaccinated would not be allowed to attend offline class",
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
                            } else if (strength >= 5) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    backgroundColor: LightColors.kDarkBlue,
                                    title: new Text("Cannot Attend offline"),
                                    content: new Text(
                                      "Maximum seating capacity reached, please attend online class through MS Teams",
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
                            } else {
                              if (this.mounted)
                                setState(() {
                                  strength += widget.offline == false ? 1 : -1;
                                  widget.offline = !widget.offline;
                                  AuthService(
                                          uid: widget.userid,
                                          docid: widget.docid)
                                      .updateTask(widget.docid, strength,
                                          widget.offline);
                                });
                            }
                          },
                          activeColor: Colors.green,
                        ),
                        ActionChip(
                          onPressed: () => {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return AlertDialog(
                                  backgroundColor: LightColors.kRed,
                                  title: new Text("Disenroll from lecture"),
                                  content: new Text(
                                    "Deleting this lecture would remove this from your schedule, however you can add it back again !",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("Yes"),
                                      onPressed: () {
                                        if (this.mounted)
                                          setState(() {
                                            int strength2 =
                                                widget.offline == false
                                                    ? 0
                                                    : -1;
                                            AuthService(
                                                    uid: widget.userid,
                                                    docid: widget.docid)
                                                .deleteTaskUser(
                                                    widget.currentFilled +
                                                        strength2);
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
                          label: Text(
                            "Disenroll",
                            style: TextStyle(
                                color: widget.cardColor,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: LightColors.kLavender,
                        ),
                      ],
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
