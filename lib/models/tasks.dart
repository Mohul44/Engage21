class Task {
  final String title;
  final String subtitle;
  final String startTime;
  final String venue;
  final String documentuid;
  List<String> names;
  bool offline;
  int currentFilled;
  String link;
  int vaccine;
  int maxCap;
  //map consisting of all users with their value false indicating online class and true indicating offline
  Map<dynamic, dynamic> mp;
  // map consisting of all users with their respective attendance
  Map<dynamic, dynamic> mp2;
  List<dynamic> repeat;
  Task(
      {this.documentuid,
      this.title,
      this.subtitle,
      this.startTime,
      this.venue,
      this.currentFilled,
      this.names,
      this.offline,
      this.mp,
      this.mp2,
      this.link,
      this.vaccine,
      this.repeat,this.maxCap});
}
