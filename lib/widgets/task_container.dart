import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final String title;
  // final String subtitle;
  final Color boxColor;
  final String teacher;
  final String venue;
  TaskContainer({
    this.title,
    // this.subtitle,
    this.boxColor,
    this.teacher,
    this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: LightColors.kLavender),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "${venue}        ${teacher}",
              style: TextStyle(
                fontSize: 14.0,
                color: LightColors.kPalePink,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
