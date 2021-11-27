import 'package:engage_scheduler/models/tasks.dart';
import 'package:engage_scheduler/screens/add_task_home.dart';
import 'package:engage_scheduler/screens/update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:engage_scheduler/screens/calendar_page.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:engage_scheduler/widgets/task_column.dart';
import 'package:engage_scheduler/widgets/active_project_card.dart';
import 'package:engage_scheduler/widgets/top_container.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:engage_scheduler/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'tasks_list.dart';
import 'package:engage_scheduler/models/tasks.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      Firestore.instance.collection("users");
  int vaccine = 2;
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
      drawer: FutureBuilder<FirebaseUser>(
          future: AuthService().currentUser(),
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
            String userid = snapshot.data.uid;
            double font_size = 18;
            double icon_size = 20;
            return Drawer(
              elevation: 25,
              child: Container(
                color: LightColors.kDarkBlue,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // const DrawerHeader(
                    //   decoration: BoxDecoration(
                    //     color: LightColors.kDarkBlue,
                    //   ),
                    //   child: Text('Drawer Header'),
                    // ),
                    Container(
                      height: 200,
                      padding: EdgeInsets.fromLTRB(10, 70, 0, 0),
                      color: LightColors.kDarkBlue,
                      child: Text(
                        "Welcome\nBrowse through ... ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white70,
                        size: 25,
                      ),
                      title: const Text(
                        'Calendar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage(userid)),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.note_alt,
                        color: Colors.white70,
                        size: 25.0,
                      ),
                      title: const Text(
                        'Add task',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTask(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.account_circle_sharp,
                        color: Colors.white70,
                        size: 25.0,
                      ),
                      title: const Text(
                        'Update Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateProfile(userid)),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.cancel,
                        color: Colors.white70,
                        size: 25.0,
                      ),
                      title: const Text(
                        'Sign out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onTap: () => AuthService().signOut(),
                    ),
                  ],
                ),
              ),
            );
          }),
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
            int totalLectures = 0;
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
                              IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: LightColors.kLavender,
                                  size: 30.0,
                                ),
                                onPressed: () => {
                                  Scaffold.of(context).openDrawer(),
                                },
                              ),
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
                                            vaccine = snapshot.data['Vaccine'];
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
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection('users')
                          .document(userUid)
                          .snapshots(),
                      builder: (context, snapshot3) {
                        if (!snapshot3.hasData) {
                          return new Text(
                            "Loading",
                            style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        subheading('My Tasks'),
                                        ElevatedButton.icon(
                                          label: Text(
                                            "Calendar",
                                            style: TextStyle(
                                                color: LightColors.kLavender),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: LightColors.kGreen,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12), // <-- Radius
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                20, 5, 20, 5),
                                          ),
                                          icon: Icon(
                                            Icons.calendar_today,
                                            size: 20.0,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CalendarPage(userid)),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    TaskColumn(
                                        icon: Icons.blur_circular,
                                        iconBackgroundColor: LightColors.kRed,
                                        title: 'Lectures enrolled',
                                        subtitle: snapshot3
                                            .data['Total Lectures']
                                            .toString()),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    // TaskColumn(
                                    //   icon: Icons.check_circle_outline,
                                    //   iconBackgroundColor: LightColors.kBlue,
                                    //   title: 'Done',
                                    //   subtitle: '18 tasks now. 13 started',
                                    // ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    TaskColumn(
                                      icon: Icons.medication,
                                      iconBackgroundColor:
                                          LightColors.kDarkYellow,
                                      title: 'Vaccination status',
                                      subtitle: snapshot3.data['Vaccine'] == 1
                                          ? "Not vaccinated"
                                          : snapshot3.data['Vaccine'] == 2
                                              ? "Partially vaccinated"
                                              : "Vaccinated",
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
                                          MediaQuery.of(context).size.height *
                                              0.415,
                                      width: MediaQuery.of(context).size.width,
                                      child:
                                          TaskList(userUid.toString(), vaccine),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
