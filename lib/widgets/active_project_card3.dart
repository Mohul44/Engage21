import 'package:auth_demo/authService.dart';
import 'package:auth_demo/screens/add_task_home.dart';
import 'package:auth_demo/screens/show_list.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.startTime,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Text(
                      "Max Capacity  " + widget.capacity.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Currently filled  " + widget.currentFilled.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    ActionChip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowList(widget.docid,
                                widget.currentFilled, widget.offline),
                          ),
                        )
                      },
                      label: Text(
                        "Show List",
                        style: TextStyle(
                            color: widget.cardColor,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    ActionChip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      onPressed: () => {},
                      label: Text(
                        "Delete lecture",
                        style: TextStyle(
                            color: LightColors.kRed,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         // return object of type Dialog
                    //         return AlertDialog(
                    //           backgroundColor: LightColors.kRed,
                    //           title: new Text("Delete lecture"),
                    //           content: new Text(
                    //             "Deleting this lecture would remove this from all students schedule",
                    //             style: TextStyle(color: Colors.white70),
                    //           ),
                    //           actions: <Widget>[
                    //             new FlatButton(
                    //               child: new Text("Yes"),
                    //               onPressed: () {
                    //                 if (this.mounted)
                    //                   setState(() {
                    //                     AuthService(
                    //                             uid: widget.userid,
                    //                             docid: widget.docid)
                    //                         .deleteTask();
                    //                   });
                    //                 Navigator.of(context).pop();
                    //               },
                    //             ),
                    //             // usually buttons at the bottom of the dialog
                    //             new FlatButton(
                    //               child: new Text("Cancel"),
                    //               onPressed: () {
                    //                 Navigator.of(context).pop();
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     );
                    //   },
                    //   icon: Icon(Icons.line_style, size: 20),
                    //   label: Text("Show List"),
                    //   style: ElevatedButton.styleFrom(
                    //       primary: LightColors.kPalePink),
                    // ),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         // return object of type Dialog
                    //         return AlertDialog(
                    //           backgroundColor: LightColors.kRed,
                    //           title: new Text("Delete lecture"),
                    //           content: new Text(
                    //             "Deleting this lecture would remove this from all students schedule",
                    //             style: TextStyle(color: Colors.white70),
                    //           ),
                    //           actions: <Widget>[
                    //             new FlatButton(
                    //               child: new Text("Yes"),
                    //               onPressed: () {
                    //                 if (this.mounted)
                    //                   setState(() {
                    //                     AuthService(
                    //                             uid: widget.userid,
                    //                             docid: widget.docid)
                    //                         .deleteTask();
                    //                   });
                    //                 Navigator.of(context).pop();
                    //               },
                    //             ),
                    //             // usually buttons at the bottom of the dialog
                    //             new FlatButton(
                    //               child: new Text("Cancel"),
                    //               onPressed: () {
                    //                 Navigator.of(context).pop();
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     );
                    //   },
                    //   icon: Icon(Icons.remove, size: 20),
                    //   label: Text("Delete lecture"),
                    //   style: ElevatedButton.styleFrom(
                    //       primary: LightColors.kPalePink),
                    // ),
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
