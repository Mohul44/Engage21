import 'package:cloud_firestore/cloud_firestore.dart';

class Users {

final String name;
final String email;
List<DocumentReference> taskList;
List<bool> taskBoolList;
final String userid;
int currentFilled;
  Users({ this.name,this.email, this.taskList, this.taskBoolList,this.userid});

}