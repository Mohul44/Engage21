class Task {

final String title;
final String subtitle;
final String startTime;
final String venue;
final String documentuid;
List<String> names;
bool offline;
int currentFilled;
Map<dynamic,dynamic> mp;
  Task({ this.documentuid,this.title, this.subtitle, this.startTime,this.venue,this.currentFilled,this.names,this.offline,this.mp});

}