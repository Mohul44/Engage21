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
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: widget.cardColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      widget.startTime,
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowList(widget.docid),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Show list',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
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
