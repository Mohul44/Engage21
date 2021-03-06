import 'package:engage_scheduler/authService.dart';
import 'package:engage_scheduler/screens/update_profile.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String meetLink;
  int vaccine;
  String venue;
  int vaccineReq;
  List<dynamic> mylist;
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
    this.venue,
    this.vaccineReq,
    this.meetLink,
    this.mylist,
  });

  @override
  _ActiveProjectsCard createState() => _ActiveProjectsCard();
}

class _ActiveProjectsCard extends State<ActiveProjectCard> {
  @override
  Widget build(BuildContext context) {
    double screeenHeihgt = MediaQuery.of(context).size.height * 1;
    double font_size = 16.0 / 683.4 * screeenHeihgt;
    double sized_box_spacing = 10.0 / 683.4 * screeenHeihgt;
    print("screeen ${screeenHeihgt}");
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            margin: EdgeInsets.symmetric(vertical: sized_box_spacing / 2),
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
                        fontSize: font_size,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: (font_size - 6.0),
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "IST ${widget.startTime}:00    ${widget.venue}",
                      style: TextStyle(
                        fontSize: (font_size - 6.0),
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
                            ? Text("M ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[2] == true
                            ? Text("Tu ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[3] == true
                            ? Text("W ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[4] == true
                            ? Text("Th ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[5] == true
                            ? Text("F ",
                                style: TextStyle(color: Colors.white60))
                            : Text(""),
                        widget.mylist[6] == true
                            ? Text("Sa ",
                                style: TextStyle(color: Colors.white54))
                            : Text(""),
                      ],
                    ),
                    SizedBox(
                      height: sized_box_spacing,
                    ),
                    Text(
                      "Max Capacity  " + widget.capacity.toString(),
                      style: TextStyle(
                        fontSize: (font_size - 6.0),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Currently filled  " + widget.currentFilled.toString(),
                      style: TextStyle(
                        fontSize: (font_size - 6.0),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Vacc req:  ${widget.vaccineReq == 1 ? "Not required" : widget.vaccineReq == 2 ? "Partial" : "Complete"}",
                      style: TextStyle(
                        fontSize: (font_size - 6.0),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: sized_box_spacing,
                    ),
                    Text(
                      "Attend offline",
                      style: TextStyle(
                        fontSize: (font_size - 2.0),
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
                            if (widget.vaccine < widget.vaccineReq &&
                                value == true) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    backgroundColor: LightColors.kDarkBlue,
                                    title: new Text(
                                        "Vaccination criteria not matched"),
                                    content: new Text(
                                      "Students who are not  ${widget.vaccineReq == 2 ? "partially vaccinated" : "completely vaccinated"} would not be allowed to attend offline class",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Update profile"),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateProfile(
                                                        widget.userid)),
                                          );
                                        },
                                      ),
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
                            } else if (strength >= widget.capacity &&
                                value == true) {
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
                    ActionChip(
                        backgroundColor: LightColors.kLavender,
                        label: Text(
                          "Get meet link",
                          style: TextStyle(
                              color: widget.cardColor,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => {
                              Clipboard.setData(
                                      ClipboardData(text: widget.meetLink))
                                  .then((_) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: LightColors.kDarkBlue,
                                    duration: Duration(seconds: 1),
                                    content:
                                        Text("Meet link copied to clipboard")));
                              })
                            }),
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
