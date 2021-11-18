import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:auth_demo/widgets/top_container.dart';
import 'package:auth_demo/widgets/back_button.dart';
import 'package:auth_demo/widgets/my_text_field.dart';
import 'package:auth_demo/screens/home_page.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';

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
  final GlobalKey<FormState> _addTaskFormKey = GlobalKey<FormState>();
  List<bool> mylist = [false, true, false, true, false, true, false];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            controller: StartingTime,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.name,
                            cursorColor: Theme.of(context).accentColor,
                            obscureText: false,
                            style: Theme.of(context).textTheme.headline5,
                            decoration: InputDecoration(labelText: "Time"),
                            validator: (name) {
                              if (name.isEmpty) {
                                return "Please enter time";
                              }
                              return null;
                            },
                          ),
                          SizedBox(width: 40),
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
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: MyTextField(
                          //         label: 'Date',
                          //         icon: downwardIcon,
                          //       ),
                          //     ),
                          //     HomePage.calendarIcon(),
                          //   ],
                          // )
                        ],
                      ))
                ],
              ),
            ),
            // Form(
            //   key: _addTaskFormKey,
            //   child: Expanded(
            //       child: SingleChildScrollView(
            //     padding: EdgeInsets.symmetric(horizontal: 20),
            //     child: Column(
            //       children: <Widget>[
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //              TextFormField(
            //                 controller: StartingTime,
            //                 autocorrect: false,
            //                 enableSuggestions: false,
            //                 keyboardType: TextInputType.name,
            //                 cursorColor: Theme.of(context).accentColor,
            //                 obscureText: false,
            //                 style: Theme.of(context).textTheme.headline5,
            //                 decoration: InputDecoration(labelText: "Time"),
            //                 validator: (name) {
            //                   if (name.isEmpty) {
            //                     return "Please enter time";
            //                   }
            //                   return null;
            //                 },
            //               ),
            //             SizedBox(width: 40),
            //              TextFormField(
            //                 controller: Venue,
            //                 autocorrect: false,
            //                 enableSuggestions: false,
            //                 keyboardType: TextInputType.name,
            //                 cursorColor: Theme.of(context).accentColor,
            //                 obscureText: false,
            //                 style: Theme.of(context).textTheme.headline5,
            //                 decoration: InputDecoration(labelText: "Venue"),
            //                 validator: (name) {
            //                   if (name.isEmpty) {
            //                     return "Please enter venue";
            //                   }
            //                   return null;
            //                 },
            //               ),
            //           ],
            //         ),
            //         SizedBox(height: 20),
            //         MyTextField(
            //           label: 'Description',
            //           minLines: 3,
            //           maxLines: 3,
            //         ),
            //         SizedBox(height: 20),
            //         Container(
            //           width: 100,
            //           alignment: Alignment.topLeft,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: <Widget>[
            //               Text(
            //                 'Category',
            //                 style: TextStyle(
            //                   fontSize: 18,
            //                   color: Colors.black54,
            //                 ),
            //               ),
            //               Wrap(
            //                 crossAxisAlignment: WrapCrossAlignment.start,
            //                 //direction: Axis.vertical,
            //                 alignment: WrapAlignment.start,
            //                 verticalDirection: VerticalDirection.down,
            //                 runSpacing: 0,
            //                 //textDirection: TextDirection.rtl,
            //                 spacing: 10.0,
            //                 children: <Widget>[
            //                   Chip(
            //                     label: Text("SPORT APP"),
            //                     backgroundColor: LightColors.kRed,
            //                     labelStyle: TextStyle(color: Colors.white),
            //                   ),
            //                   Chip(
            //                     label: Text("MEDICAL APP"),
            //                   ),
            //                   Chip(
            //                     label: Text("RENT APP"),
            //                   ),
            //                   Chip(
            //                     label: Text("NOTES"),
            //                   ),
            //                   Chip(
            //                     label: Text("GAMING PLATFORM APP"),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   )),
            // ),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                backgroundColor: LightColors.kDarkBlue,
                                title: new Text("Cannot Attend offline"),
                                content: new Text(
                                  "Maximum seating capacity reached, please attend online class through MS Teams",
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
                          if (_addTaskFormKey.currentState.validate()) {
                            await AuthService(uid: widget.userid).addTask(
                                Course.text,
                                Lecturer.text,
                                mylist,
                                StartingTime.text,
                                Venue.text);
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
