import 'package:auth_demo/models/tasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auth_demo/screens/calendar_page.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:auth_demo/widgets/task_column.dart';
import 'package:auth_demo/widgets/active_project_card.dart';
import 'package:auth_demo/widgets/top_container.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:auth_demo/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'tasks_list.dart';
import 'package:auth_demo/models/tasks.dart';

var name;
void getUserName(String uid) async {
  DocumentSnapshot documentSnapshot;
  await Firestore.instance
      .collection('users')
      .document(uid)
      .get()
      .then((value) => documentSnapshot = value);
  name = documentSnapshot['name'];
  print(name);
}

class HomePage extends StatelessWidget {
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      Firestore.instance.collection("users");
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: FutureBuilder<FirebaseUser>(
        future: AuthService().currentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Get Current User Email
            String userid = snapshot.data.uid;
            String userEmail = snapshot.data.email;
            getUserName(userid);
            String userName = name;
            userName = userName == null ? "Null" : userName;
            // Get Current User UID

            String userUid = snapshot.data.uid;

            return StreamProvider<List<Task>>.value(
              value: AuthService(uid: userid).tasks,
              initialData: [],
              child: Column(
                children: <Widget>[
                  TopContainer(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.account_circle_sharp,
                                  color: LightColors.kLavender, size: 30.0),
                              IconButton(
                                icon: Icon(
                                  Icons.power_settings_new,
                                  color: LightColors.kLavender,
                                ),
                                onPressed: () => AuthService().signOut(),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CircularPercentIndicator(
                                  radius: 90.0,
                                  lineWidth: 5.0,
                                  animation: true,
                                  percent: 0.75,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: LightColors.kRed,
                                  backgroundColor: LightColors.kDarkYellow,
                                  center: CircleAvatar(
                                    backgroundColor: LightColors.kBlue,
                                    radius: 35.0,
                                    backgroundImage: AssetImage(
                                      'assets/images/avatar.png',
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: StreamBuilder(
                                          stream: Firestore.instance
                                              .collection('users')
                                              .document(userUid)
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
                                            return new Text(
                                              snapshot.data['name'],
                                              style: new TextStyle(
                                                fontSize: 28.0,
                                                fontWeight: FontWeight.w600,
                                                color: LightColors.kLavender,
                                              ),
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        'Student',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: LightColors.kLavender,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        userEmail,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: LightColors.kLavender,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  subheading('My Tasks'),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CalendarPage(userid)),
                                      );
                                    },
                                    child: calendarIcon(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              TaskColumn(
                                icon: Icons.blur_circular,
                                iconBackgroundColor: LightColors.kRed,
                                title: 'In Progress',
                                subtitle: '1 tasks now. 1 started',
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TaskColumn(
                                icon: Icons.check_circle_outline,
                                iconBackgroundColor: LightColors.kBlue,
                                title: 'Done',
                                subtitle: '18 tasks now. 13 started',
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TaskColumn(
                                icon: Icons.medication,
                                iconBackgroundColor: LightColors.kDarkYellow,
                                title: 'Vaccination status',
                                subtitle: 'Not vaccinated',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              subheading('Lectures'),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.33,
                                width: MediaQuery.of(context).size.width,
                                child: TaskList(userUid.toString()),
                                // child: ListView(
                                //   scrollDirection: Axis.horizontal,
                                //   shrinkWrap: true,
                                //   children: <Widget>[
                                //       ActiveProjectCard(
                                //       cardColor: LightColors.kDarkYellow,
                                //       loadingPercent: 0.45,
                                //       title: 'Machine Learning',
                                //       subtitle: 'LTC:5105',
                                //       startTime: '4 PM',
                                //       capacity: 10,
                                //       currentFilled: 0,
                                //       offline: false,
                                //     ),
                                //        SizedBox(width: 20.0),
                                //     ActiveProjectCard(
                                //       cardColor: LightColors.kGreen,
                                //       loadingPercent: 0.25,
                                //       title: 'Kick off',
                                //       subtitle: 'Microsoft teams',
                                //       startTime: '3 PM',
                                //       capacity: 10,
                                //       currentFilled: 0,
                                //       offline: false,
                                //     ),
                                //        SizedBox(width: 20.0),
                                //      ActiveProjectCard(
                                //       cardColor: LightColors.kRed,
                                //       loadingPercent: 0.6,
                                //       title: 'Artificial Intelligence',
                                //       subtitle: 'LTC:5102',
                                //       startTime: '12 PM',
                                //       capacity: 10,
                                //       currentFilled: 0,
                                //       offline: true,
                                //     ),

                                //   ],
                                // ),
                              ),
                              // Row(
                              //   children: <Widget>[
                              //     ActiveProjectCard(
                              //       cardColor: LightColors.kGreen,
                              //       loadingPercent: 0.25,
                              //       title: 'Kick off',
                              //       subtitle: 'Microsoft teams',
                              //       startTime: '3 PM',
                              //       capacity: 10,
                              //       currentFilled: 0,
                              //       offline: false,
                              //     ),
                              //     SizedBox(width: 20.0),
                              //     ActiveProjectCard(
                              //       cardColor: LightColors.kRed,
                              //       loadingPercent: 0.6,
                              //       title: 'Artificial Intelligence',
                              //       subtitle: 'LTC:5102',
                              //       startTime: '12 PM',
                              //       capacity: 10,
                              //       currentFilled: 0,
                              //       offline: true,
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   children: <Widget>[
                              //     ActiveProjectCard(
                              //       cardColor: LightColors.kDarkYellow,
                              //       loadingPercent: 0.45,
                              //       title: 'Machine Learning',
                              //       subtitle: 'LTC:5105',
                              //       startTime: '4 PM',
                              //       capacity: 10,
                              //       currentFilled: 0,
                              //       offline: false,
                              //     ),
                              //     SizedBox(width: 20.0),
                              //     ActiveProjectCard(
                              //       cardColor: LightColors.kBlue,
                              //       loadingPercent: 0.9,
                              //       title: 'Online Flutter Course',
                              //       subtitle: 'Online only',
                              //       startTime: '2 PM',
                              //       capacity: 10,
                              //       currentFilled: 0,
                              //       offline: true,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
