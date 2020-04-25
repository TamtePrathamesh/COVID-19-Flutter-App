class IndiaStateData{
  int id;
  int active;
  int value;
  String name;
  String confirmed;
  String recovered;
  String deaths;
  String isoCode;

  IndiaStateData({this.id,this.active,this.value,this.name,this.confirmed,this.recovered,this.deaths,this.isoCode});


  
  factory IndiaStateData.fromJson(Map<String, dynamic> json) {
    return IndiaStateData(
      id: json["id"] as int,
      active:json["active"] as int,
      value:json["value"] as int,
      name:json["name"] as String,
      confirmed:json["confirmed"] as String,
      recovered:json["recovered"] as String,
      deaths:json["deaths"]as String,
      isoCode:json["isoCode"]as String
     );
  }

}