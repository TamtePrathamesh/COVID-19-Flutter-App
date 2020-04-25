import 'package:meta/meta.dart';
import 'dart:convert';

CovidTrackerModel homeModelFromJson(String str) => CovidTrackerModel.fromMap(json.decode(str));

String homeModelToJson(CovidTrackerModel data) => json.encode(data.toMap());

class CovidTrackerModel {
    Confirmed confirmed;
    Confirmed recovered;
    Confirmed deaths;
    String dailySummary;
    CountryDetail dailyTimeSeries;
    String image;
    String source;
    String countries;
    CountryDetail countryDetail;
    DateTime lastUpdate;

    CovidTrackerModel({
        @required this.confirmed,
        @required this.recovered,
        @required this.deaths,
        @required this.dailySummary,
        @required this.dailyTimeSeries,
        @required this.image,
        @required this.source,
        @required this.countries,
        @required this.countryDetail,
        @required this.lastUpdate,
    });

    factory CovidTrackerModel.fromMap(Map<String, dynamic> json) => CovidTrackerModel(
        confirmed: json["confirmed"] == null ? null : Confirmed.fromMap(json["confirmed"]),
        recovered: json["recovered"] == null ? null : Confirmed.fromMap(json["recovered"]),
        deaths: json["deaths"] == null ? null : Confirmed.fromMap(json["deaths"]),
        dailySummary: json["dailySummary"] == null ? null : json["dailySummary"],
        dailyTimeSeries: json["dailyTimeSeries"] == null ? null : CountryDetail.fromMap(json["dailyTimeSeries"]),
        image: json["image"] == null ? null : json["image"],
        source: json["source"] == null ? null : json["source"],
        countries: json["countries"] == null ? null : json["countries"],
        countryDetail: json["countryDetail"] == null ? null : CountryDetail.fromMap(json["countryDetail"]),
        lastUpdate: json["lastUpdate"] == null ? null : DateTime.parse(json["lastUpdate"]),
    );

  factory CovidTrackerModel.fromJson(Map<String, dynamic> json) {
    return CovidTrackerModel(
     confirmed: json["confirmed"] == null ? null : Confirmed.fromMap(json["confirmed"]),
        recovered: json["recovered"] == null ? null : Confirmed.fromMap(json["recovered"]),
        deaths: json["deaths"] == null ? null : Confirmed.fromMap(json["deaths"]),
        dailySummary: json["dailySummary"] == null ? null : json["dailySummary"],
        dailyTimeSeries: json["dailyTimeSeries"] == null ? null : CountryDetail.fromMap(json["dailyTimeSeries"]),
        image: json["image"] == null ? null : json["image"],
        source: json["source"] == null ? null : json["source"],
        countries: json["countries"] == null ? null : json["countries"],
        countryDetail: json["countryDetail"] == null ? null : CountryDetail.fromMap(json["countryDetail"]),
        lastUpdate: json["lastUpdate"] == null ? null : DateTime.parse(json["lastUpdate"]),
    );
  }
    Map<String, dynamic> toMap() => {
        "confirmed": confirmed == null ? null : confirmed.toMap(),
        "recovered": recovered == null ? null : recovered.toMap(),
        "deaths": deaths == null ? null : deaths.toMap(),
        "dailySummary": dailySummary == null ? null : dailySummary,
        "dailyTimeSeries": dailyTimeSeries == null ? null : dailyTimeSeries.toMap(),
        "image": image == null ? null : image,
        "source": source == null ? null : source,
        "countries": countries == null ? null : countries,
        "countryDetail": countryDetail == null ? null : countryDetail.toMap(),
        "lastUpdate": lastUpdate == null ? null : lastUpdate.toIso8601String(),
    };
}

class Confirmed {
    int value;
    String detail;

    Confirmed({
        @required this.value,
        @required this.detail,
    });

    factory Confirmed.fromMap(Map<String, dynamic> json) => Confirmed(
        value: json["value"] == null ? null : json["value"],
        detail: json["detail"] == null ? null : json["detail"],
    );

    Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "detail": detail == null ? null : detail,
    };
}

class CountryDetail {
    String pattern;
    String example;

    CountryDetail({
        @required this.pattern,
        @required this.example,
    });

    factory CountryDetail.fromMap(Map<String, dynamic> json) => CountryDetail(
        pattern: json["pattern"] == null ? null : json["pattern"],
        example: json["example"] == null ? null : json["example"],
    );

    Map<String, dynamic> toMap() => {
        "pattern": pattern == null ? null : pattern,
        "example": example == null ? null : example,
    };
}
