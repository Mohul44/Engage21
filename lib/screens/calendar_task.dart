import 'package:auth_demo/authService.dart';
import 'package:auth_demo/models/tasks.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:auth_demo/widgets/task_container.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:auth_demo/widgets/active_project_card.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:auth_demo/dates_list.dart' as global;

class CalendarTaskList extends StatefulWidget {
  final String userid;
  final int weekDay;
  const CalendarTaskList(this.userid, this.weekDay);
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<CalendarTaskList> {
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 46),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style: TextStyle(
            fontSize: 20.0, color: LightColors.kLavender, letterSpacing: 5),
      ),
    );
  }

  final CollectionReference _usersCollection =
      Firestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    int count = 0;
    List<Color> myColors = [
      LightColors.kBlue,
      LightColors.kGreen,
      LightColors.kRed,
      Colors.green,
    ];
    return Container(
      child: Expanded(
        flex: 5,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: global.time.length,
          itemBuilder: (BuildContext context, int index) {
            print(
                "value at ${widget.weekDay} ${index} is${global.twoDList[widget.weekDay][index]}");
            if (global.twoDList[widget.weekDay][index][0]
                .toString()
                .isNotEmpty) {
              return TaskContainer(
                title: global.twoDList[widget.weekDay][index][0],
                teacher: global.twoDList[widget.weekDay][index][1],
                venue: global.twoDList[widget.weekDay][index][2],
                boxColor: myColors[index % myColors.length],
              );
            }
            return _dashedText();
          },
        ),
      ),
    );
  }
}
