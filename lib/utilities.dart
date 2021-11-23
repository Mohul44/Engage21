import 'package:auth_demo/authService.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String getAm(int time) {
  return '${time} ${time < 8 ? 'PM' : 'AM'}';
}
