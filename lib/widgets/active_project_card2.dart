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
  int length;
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
    this.length,
  });

  @override
  _ActiveProjectsCard createState() => _ActiveProjectsCard();
}

class _ActiveProjectsCard extends State<ActiveProjectCard> {
  Container weekdayContainer(String day, double op) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: LightColors.kLavender.withOpacity(op),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 30 / 683.4 * screenHeight,
      width: 40,

      child: Text(day,
          style:
              TextStyle(color: widget.cardColor, fontWeight: FontWeight.bold)),
      //padding: EdgeInsets.all(6),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
                      fontSize: 20.0 / 683.4 * screenHeight,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width * .54,
                  margin: EdgeInsets.symmetric(
                      vertical: 5.0 / 683.4 * screenHeight),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: widget.cardColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            height: 2,
                          ),
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              fontSize: 14.0 / 683.4 * screenHeight,
                              color: Colors.white54,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "IST ${widget.startTime}:00",
                            style: TextStyle(
                              fontSize: 14.0 / 683.4 * screenHeight,
                              color: Colors.white54,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 20 / 683.4 * screenHeight,
                          ),
                          Text(
                            "Students enrolled:  " + widget.length.toString(),
                            style: TextStyle(
                              fontSize: 14.0 / 683.4 * screenHeight,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Seats reserved:  " +
                                widget.currentFilled.toString() +
                                "/" +
                                widget.capacity.toString(),
                            style: TextStyle(
                              fontSize: 14.0 / 683.4 * screenHeight,
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
                            height: 20 / 683.4 * screenHeight,
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
                            height: 60 / 683.4 * screenHeight,
                            width: 90,
                            child: !widget.offline
                                ? ActionChip(
                                    backgroundColor: Colors.white,
                                    label: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 40,
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: widget.cardColor,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                            height: 10 / 683.4 * screenHeight,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              snapshot.data['Repeat'][0]
                                  ? weekdayContainer("Sun", 1)
                                  : Container(), //weekdayContainer("Sun", 0.3),
                              snapshot.data['Repeat'][1]
                                  ? weekdayContainer("Mon", 1)
                                  : Container(), //weekdayContainer("Mon", 0.3),
                              snapshot.data['Repeat'][2]
                                  ? weekdayContainer("Tue", 1)
                                  : Container(), //weekdayContainer("Tue", 0.3),
                              snapshot.data['Repeat'][3]
                                  ? weekdayContainer("Wed", 1)
                                  : Container(), //weekdayContainer("Wed", 0.3),
                              // snapshot.data['Repeat'][4]
                              //     ? weekdayContainer("Thu", 1)
                              //     : Container(), //weekdayContainer("Thu", 0.3),
                              // snapshot.data['Repeat'][5]
                              //     ? weekdayContainer("Fri", 1)
                              //     : Container(), //weekdayContainer("Fri", 0.3),
                              // snapshot.data['Repeat'][6]
                              //     ? weekdayContainer("Sat", 1)
                              //     : Container(), //weekdayContainer("Sat", 0.3),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // snapshot.data['Repeat'][0]
                              //     ? weekdayContainer("Sun", 1)
                              //     : Container(), //weekdayContainer("Sun", 0.3),
                              // snapshot.data['Repeat'][1]
                              //     ? weekdayContainer("Mon", 1)
                              //     : Container(), //weekdayContainer("Mon", 0.3),
                              // snapshot.data['Repeat'][2]
                              //     ? weekdayContainer("Tue", 1)
                              //     : Container(), //weekdayContainer("Tue", 0.3),
                              // snapshot.data['Repeat'][3]
                              //     ? weekdayContainer("Wed", 1)
                              //     : Container(), //weekdayContainer("Wed", 0.3),
                              snapshot.data['Repeat'][4]
                                  ? weekdayContainer("Thu", 1)
                                  : Container(), //weekdayContainer("Thu", 0.3),
                              snapshot.data['Repeat'][5]
                                  ? weekdayContainer("Fri", 1)
                                  : Container(), //weekdayContainer("Fri", 0.3),
                              snapshot.data['Repeat'][6]
                                  ? weekdayContainer("Sat", 1)
                                  : Container(), //weekdayContainer("Sat", 0.3),
                            ],
                          ),
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
