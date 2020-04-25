import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountriesStats {
  final String country_name;
  final String cases;
  final String deaths;
  final String region;
  final String total_recovered;
  final String new_deaths;
  final String new_cases;
  final String serious_critical;
  Marker marker;
  CountriesStats(
      {this.country_name,
      this.cases,
      this.deaths,
      this.region,
      this.total_recovered,
      this.new_deaths,
      this.new_cases,
      this.serious_critical});

  factory CountriesStats.fromJson(Map<String, dynamic> json) {
    return CountriesStats(
        country_name: json["country_name"],
        cases: json["cases"],
        deaths: json["deaths"],
        region: json["region"],
        total_recovered: json["total_recovered"],
        new_deaths: json["new_deaths"],
        new_cases: json["new_cases"],
        serious_critical: json["serious_critical"]);
  }
}
