class CtLatLngR {
  String country;
  String countrycode;
  String latitude;
  String longitude;
  int confirmed;
  int  deaths;
  int recovered;
 int active;

  CtLatLngR(
      {this.country, this.countrycode, this.latitude, this.longitude,this.confirmed,this.deaths,this.recovered});
    

  factory CtLatLngR.fromJson(Map<String, dynamic> json) {
    return CtLatLngR(
      country: json["country"] as String,
      countrycode: json["countrycode"] as String,
      latitude: json["latitude"] as String,
      longitude: json["longitude"] as String,
     confirmed:json["confirmed"] as int,
     deaths:json["deaths"]as int,
     recovered:json["recovered"]as int,

     );
  }
}