import 'package:auth_demo/authService.dart';
import 'package:auth_demo/models/tasks.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:auth_demo/widgets/active_project_card3.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';

class StudentList extends StatefulWidget {
  final String userid;
  const StudentList(this.userid);
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final CollectionReference _usersCollection =
      Firestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    List<Color> myColors = [
      LightColors.kRed,
      LightColors.kGreen,
      LightColors.kDarkBlue,
      LightColors.kDarkYellow,
    ];
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          print("task is ${tasks[index]}");
          print("task map is ${tasks[index].mp}");
          if (tasks[index].mp.containsKey(widget.userid))
            return Container(
              padding: EdgeInsets.all(5.0),
              child: ActiveProjectCard(
                cardColor: myColors[index % (myColors.length)],
                loadingPercent: 0.45,
                title: tasks[index].title,
                subtitle: tasks[index].subtitle,
                startTime: tasks[index].startTime,
                capacity: 10,
                currentFilled: tasks[index].currentFilled,
                offline: tasks[index].mp[widget.userid.toString()],
                docid: tasks[index].documentuid,
                userid: widget.userid,
              ),
            );
          else
            return Container();
        });
  }
}
