import 'package:engage_scheduler/authService.dart';
import 'package:engage_scheduler/models/tasks.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:engage_scheduler/widgets/active_project_card2.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';

class AddTaskStudent extends StatefulWidget {
  final String userid;
  const AddTaskStudent(this.userid);
  @override
  _StudentTaskListState createState() => _StudentTaskListState();
}

class _StudentTaskListState extends State<AddTaskStudent> {
  final CollectionReference _usersCollection =
      Firestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);

    List<Color> myColors = [
      LightColors.kBlue,
      LightColors.kRed,
      LightColors.kGreen,
      LightColors.kDarkBlue,
    ];
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          print("task is ${tasks[index]}");
          print("task map is ${tasks[index].mp}");
          final boolIsAdded = tasks[index].mp.containsKey(widget.userid);
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
              //offline is already added or not,
              offline: boolIsAdded,
              docid: tasks[index].documentuid,
              userid: widget.userid,
            ),
          );
        });
  }
}
