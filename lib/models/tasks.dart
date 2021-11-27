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
  Map<dynamic, dynamic> mp;
  Map<dynamic, dynamic> mp2;
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
      this.vaccine});
}
