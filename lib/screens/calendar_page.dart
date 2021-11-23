import 'package:engage_scheduler/authService.dart';
import 'package:engage_scheduler/models/tasks.dart';
import 'package:engage_scheduler/screens/add_task_home.dart';
import 'package:engage_scheduler/screens/calendar_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:engage_scheduler/dates_list.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:engage_scheduler/widgets/calendar_dates.dart';
import 'package:engage_scheduler/widgets/task_container.dart';
import 'package:engage_scheduler/screens/create_new_task_page.dart';
import 'package:engage_scheduler/widgets/back_button.dart';
import 'package:provider/provider.dart';
import 'package:engage_scheduler/authService.dart';

class CalendarPage extends StatefulWidget {
  final String userid;
  const CalendarPage(this.userid);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int currentDay = dayOfWeek;
  void onPressHandler(int day) {
    setState(() {
      currentDay = day;
    });
  }

  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style: TextStyle(
            fontSize: 20.0, color: LightColors.kLavender, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      value: AuthService(uid: widget.userid).tasks,
      initialData: [],
      child: Scaffold(
        backgroundColor: LightColors.kDarkBlue,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              0,
            ),
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(widget.userid)
                    .snapshots(),
                builder: (context, snapshot) {
                  AuthService().updateCalendar();
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
                  int role = snapshot.data['role'];
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyBackButton(),
                          role == 2
                              ? Container(
                                  height: 40.0,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: LightColors.kLightGreen,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateNewTaskPage(widget.userid),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Add Lecture',
                                        style: TextStyle(
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 40.0,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: LightColors.kLightYellow,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddTask(),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Add task',
                                        style: TextStyle(
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Productive Day, ${snapshot.data['name']}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'All lecture schedule',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 38.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                              onPressed: () => onPressHandler(index),
                              child: Text(
                                days[index],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: index == currentDay
                                        ? LightColors.kRed
                                        : index == dayOfWeek
                                            ? Colors.white
                                            : Colors.white54,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                            // return CalendarDates(
                            //   day: days[index],
                            //   date: dates[index],
                            //   dayColor: index == currentDay
                            //       ? LightColors.kRed
                            //       : Colors.white70,
                            //   dateColor: index == 0
                            //       ? LightColors.kRed
                            //       : LightColors.kLavender,
                            //     // onPress : onPressHandler(index);
                            // );
                          },
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: ListView.builder(
                                    itemCount: time.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 48.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${time[index]} ${time[index] >= 12 ? 'PM' : 'AM'}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: LightColors.kLavender,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CalendarTaskList(widget.userid, currentDay),
                                // Expanded(
                                //   flex: 5,
                                //   child: ListView(
                                //     shrinkWrap: true,
                                //     physics: NeverScrollableScrollPhysics(),
                                //     children: <Widget>[
                                //       _dashedText(),
                                //       TaskContainer(
                                //         title: 'Project Research',
                                //         subtitle:
                                //             'Discuss with the colleagues about the future plan',
                                //         boxColor: LightColors.kLightYellow2,
                                //       ),
                                //       _dashedText(),
                                //       TaskContainer(
                                //         title: 'Work on Medical App',
                                //         subtitle: 'Add medicine tab',
                                //         boxColor: LightColors.kLavender,
                                //       ),
                                //       TaskContainer(
                                //         title: 'Call',
                                //         subtitle: 'Call to david',
                                //         boxColor: LightColors.kPalePink,
                                //       ),
                                //       TaskContainer(
                                //         title: 'Design Meeting',
                                //         subtitle:
                                //             'Discuss with designers for new task for the medical app',
                                //         boxColor: LightColors.kLightGreen,
                                //       ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
