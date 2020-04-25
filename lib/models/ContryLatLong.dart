class CountriesLatLong {
  String country;
  String country_code;
  String province;
  Coordinates coordinates;
  Latest ls;
  CountriesLatLong(
      {this.country, this.country_code, this.province, this.coordinates,this.ls});

  factory CountriesLatLong.fromJson(Map<String, dynamic> json) {
    return CountriesLatLong(
      country: json["country"] as String,
      country_code: json["country_code"] as String,
      province: json["province"] as String,
      coordinates: Coordinates.fromJson(json["coordinates"]),
      ls:Latest.fromJson(json['latest'])
    );
  }
}

class Coordinates {
  String latitude;
  String longitude;

  Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
        latitude: json["latitude"] as String,
        longitude: json["longitude"] as String);
  }
}

class Latest{
  int confirmed;
  int death;
  int recovered;
   Latest({this.confirmed, this.death,this.recovered});

  factory Latest.fromJson(Map<String, dynamic> json) {
    return Latest(
        confirmed: json["confirmed"] as int,
        death: json["deaths"] as int,
         recovered: json["recovered"] as int,
        );
  }

}