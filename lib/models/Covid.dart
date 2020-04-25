
class Covid {
  int confvalue;
  int recvalue;
  int deaths;
  String lastupdate;

  Covid({this.confvalue, this.recvalue, this.deaths, this.lastupdate});

  factory Covid.fromJson(Map<dynamic, dynamic> json) {
    return Covid(
        confvalue: json['confirmed']['value'] as int,
        recvalue: json['recovered']['value'] as int,
        deaths: json['deaths']['value'] as int,
        lastupdate: json['lastUpdate'] as String);
  }
}

 