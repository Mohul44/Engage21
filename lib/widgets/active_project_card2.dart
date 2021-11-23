import 'package:engage_scheduler/authService.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  });

  @override
  _ActiveProjectsCard createState() => _ActiveProjectsCard();
}

class _ActiveProjectsCard extends State<ActiveProjectCard> {
  Container weekdayContainer(String day, double op) {
    return Container(
      alignment: Alignment.center,
      height: 25,
      width: 35,
      color: LightColors.kLavender.withOpacity(op),
      child: Text(day,
          style:
              TextStyle(color: widget.cardColor, fontWeight: FontWeight.bold)),
      //padding: EdgeInsets.all(6),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Tasks')
                  .document(widget.docid)
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
                return Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: widget.cardColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white54,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "IST ${widget.startTime}:00",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white54,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Max Capacity  " + widget.capacity.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Currently filled  " +
                                widget.currentFilled.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // Text(
                          //   "Starting time  " + widget.startTime.toString(),
                          //   style: TextStyle(
                          //     fontSize: 18.0,
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          // ActionChip(
                          //   avatar: CircleAvatar(
                          //     backgroundColor: widget.cardColor,
                          //     child: const Icon(
                          //       Icons.add,
                          //       color: LightColors.kLavender,
                          //     ),
                          //   ),
                          //   label: Text(
                          //     "Add",
                          //     style: TextStyle(
                          //         fontSize: 20,
                          //         color: widget.cardColor,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          //   onPressed: () {
                          //     if (this.mounted)
                          //       setState(() {
                          //         AuthService(
                          //                 uid: widget.userid,
                          //                 docid: widget.docid)
                          //             .addUserToTask();
                          //       });
                          //   },
                          //   backgroundColor: LightColors.kLavender,
                          // ),
                          // ignore: deprecated_member_use
                          SizedBox(
                            height: 60,
                            width: 90,
                            child: !widget.offline
                                ? ActionChip(
                                    avatar: CircleAvatar(
                                      backgroundColor: widget.cardColor,
                                      child: const Icon(
                                        Icons.add,
                                        color: LightColors.kLavender,
                                      ),
                                    ),
                                    label: Text(
                                      "Add",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: widget.cardColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      if (this.mounted)
                                        setState(() {
                                          AuthService(
                                                  uid: widget.userid,
                                                  docid: widget.docid)
                                              .addUserToTask();
                                        });
                                    },
                                    backgroundColor: LightColors.kLavender,
                                  )
                                : Text(
                                    "Added to calendar !",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white54,
                                        fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              snapshot.data['Repeat'][0]
                                  ? weekdayContainer("Sun", 1)
                                  : weekdayContainer("Sun", 0.3),
                              snapshot.data['Repeat'][1]
                                  ? weekdayContainer("Mon", 1)
                                  : weekdayContainer("Mon", 0.3),
                              snapshot.data['Repeat'][2]
                                  ? weekdayContainer("Tue", 1)
                                  : weekdayContainer("Tue", 0.3),
                              snapshot.data['Repeat'][3]
                                  ? weekdayContainer("Wed", 1)
                                  : weekdayContainer("Wed", 0.3),
                              snapshot.data['Repeat'][4]
                                  ? weekdayContainer("Thu", 1)
                                  : weekdayContainer("Thu", 0.3),
                              snapshot.data['Repeat'][5]
                                  ? weekdayContainer("Fri", 1)
                                  : weekdayContainer("Fri", 0.3),
                              snapshot.data['Repeat'][6]
                                  ? weekdayContainer("Sat", 1)
                                  : weekdayContainer("Sat", 0.3),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
