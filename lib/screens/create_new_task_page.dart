import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:engage_scheduler/widgets/top_container.dart';
import 'package:engage_scheduler/widgets/back_button.dart';
import 'package:engage_scheduler/widgets/my_text_field.dart';
import 'package:engage_scheduler/screens/home_page.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:engage_scheduler/dates_list.dart' as global;

import '../authService.dart';

class CreateNewTaskPage extends StatefulWidget {
  final String userid;
  const CreateNewTaskPage(this.userid);
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  TextEditingController Course = new TextEditingController();
  TextEditingController Lecturer = new TextEditingController();
  TextEditingController StartingTime = new TextEditingController();
  TextEditingController Venue = new TextEditingController();
  GlobalKey<FormState> _addTaskFormKey = GlobalKey<FormState>();
  List<bool> mylist = [false, true, false, true, false, true, false];
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  String _timeIndex = "8";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    void _selectTime() async {
      final TimeOfDay newTime = await showTimePicker(
        minuteLabelText: "00",
        context: context,
        initialTime: _time,
      );
      if (newTime != null) {
        setState(() {
          _time = newTime;
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Create new task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                      key: _addTaskFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: Course,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.name,
                            cursorColor: Theme.of(context).accentColor,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline5,
                            decoration: InputDecoration(labelText: "Course"),
                            validator: (name) {
                              if (name.isEmpty) {
                                return "Please enter course";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: Lecturer,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.name,
                            cursorColor: Theme.of(context).accentColor,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline5,
                            decoration: InputDecoration(labelText: "Lecturer"),
                            validator: (name) {
                              if (name.isEmpty) {
                                return "Please enter course";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: Venue,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.name,
                            cursorColor: Theme.of(context).accentColor,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline5,
                            decoration: InputDecoration(labelText: "Venue"),
                            validator: (name) {
                              if (name.isEmpty) {
                                return "Please enter venue";
                              }
                              return null;
                            },
                          ),
                          SizedBox(width: 40),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: DropdownButton(
                              dropdownColor: LightColors.kRed,
                              value: _timeIndex,
                              style: new TextStyle(
                                color: LightColors.kLavender,
                              ),
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: global.time.map((items) {
                                return DropdownMenuItem(
                                    value: items.toString(),
                                    child: Text(
                                        '${items.toString()} ${items >= 12 ? 'PM' : 'AM'}'));
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  _timeIndex = newValue;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: <Widget>[
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ButtonTheme(
                                        height: 40,
                                        buttonColor: mylist[0] == false
                                            ? LightColors.kRed
                                            : LightColors.kDarkBlue,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mylist[0] == false
                                                ? LightColors.kPalePink
                                                : LightColors.kRed,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              mylist[0] = !mylist[0];
                                              print(mylist);
                                            });
                                          },
                                          child: Text('Sun'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonTheme(
                                        height: 40,
                                        buttonColor: mylist[1] == false
                                            ? LightColors.kRed
                                            : LightColors.kDarkBlue,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mylist[1] == false
                                                ? LightColors.kPalePink
                                                : LightColors.kRed,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              mylist[1] = !mylist[1];
                                              print(mylist);
                                            });
                                          },
                                          child: Text('Mon'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonTheme(
                                        height: 40,
                                        buttonColor: mylist[0] == false
                                            ? LightColors.kRed
                                            : LightColors.kDarkBlue,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mylist[2] == false
                                                ? LightColors.kPalePink
                                                : LightColors.kRed,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              mylist[2] = !mylist[2];
                                              print(mylist);
                                            });
                                          },
                                          child: Text('Tue'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonTheme(
                                        height: 40,
                                        buttonColor: mylist[0] == false
                                            ? LightColors.kRed
                                            : LightColors.kDarkBlue,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mylist[3] == false
                                                ? LightColors.kPalePink
                                                : LightColors.kRed,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              mylist[3] = !mylist[3];
                                              print(mylist);
                                            });
                                          },
                                          child: Text('Wed'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ButtonTheme(
                                        height: 40,
                                        buttonColor: mylist[0] == false
                                            ? LightColors.kRed
                                            : LightColors.kDarkBlue,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mylist[4] == false
                                                ? LightColors.kPalePink
                                                : LightColors.kRed,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              mylist[4] = !mylist[4];
                                              print(mylist);
                                            });
                                          },
                                          child: Text('Thu'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonTheme(
                                        height: 40,
                                        buttonColor: mylist[0] == false
                                            ? LightColors.kRed
                                            : LightColors.kDarkBlue,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mylist[5] == false
                                                ? LightColors.kPalePink
                                                : LightColors.kRed,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              mylist[5] = !mylist[5];
                                              print(mylist);
                                            });
                                          },
                                          child: Text('Fri'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonTheme(
                                        height: 40,
                                        buttonColor: mylist[0] == false
                                            ? LightColors.kRed
                                            : LightColors.kDarkBlue,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mylist[6] == false
                                                ? LightColors.kPalePink
                                                : LightColors.kRed,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              mylist[6] = !mylist[6];
                                              print(mylist);
                                            });
                                          },
                                          child: Text('Sat'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              height: 100,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: ElevatedButton(
                        child: Text('Register'),
                        onPressed: () async {
                          if (_addTaskFormKey.currentState.validate()) {
                            await AuthService(uid: widget.userid)
                                .addTask(Course.text, Lecturer.text, mylist,
                                    _timeIndex, Venue.text)
                                .then((value) => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AlertDialog(
                                          backgroundColor:
                                              LightColors.kDarkBlue,
                                          title: new Text(
                                              "Lecture slot added successfully"),
                                          content: new Text(
                                            "Return to home page to view changes",
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                          actions: <Widget>[
                                            // usually buttons at the bottom of the dialog
                                            new FlatButton(
                                              child: new Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ))
                                .catchError((onError) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    backgroundColor: LightColors.kDarkBlue,
                                    title: new Text("Clash"),
                                    content: new Text(
                                      "Choose another time or day",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          }
                          ;
                        }),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
