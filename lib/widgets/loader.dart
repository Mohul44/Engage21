import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:engage_scheduler/theme/theme_home.dart';
import 'package:engage_scheduler/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Scaffold(
          backgroundColor: LightColors.kDarkBlue,
          body: Center(
              child: SpinKitFoldingCube(
            color: Colors.white,
            size: 50.0,
          ))),
    );
  }
}
