import 'package:challenge3/models/CovidTrackerModel.dart';
import 'package:challenge3/models/country_model.dart';
import 'package:challenge3/models/daily_model.dart';
import 'package:challenge3/models/detail_country.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

String api="covid_19_api";

class CovidTrackerService with ChangeNotifier {

  CovidTrackerModel home;
  

  Future<CovidTrackerModel> getCovidTrackerData() async {
    final response = await http.get("$api/api");
    if (response.statusCode == 200) {
    notifyListeners();
      var res = homeModelFromJson(response.body);
      home = res;
      return res;
    } else {
      return null;
    }
  }
}

class CovidTrackerCountry  with ChangeNotifier{
  
  CountryModel country;
  

  Future<CountryModel> getCountryProvider() async {
    final response = await http.get("$api/api/countries/");
    if (response.statusCode == 200) {
      notifyListeners();
      var res = countryModelFromJson(response.body);
      country = res;
      return country;
    } else {
      return null;
    }
  }
}

class DailyProvider with ChangeNotifier {
 
  List<DailyModel> daily;

  Future<List<DailyModel>> getDailyProvider(String id) async {
    final response = await http.get("$api/api/daily/$id");
    if (response.statusCode == 200) {
      notifyListeners();
      var res = dailyModelFromJson(response.body);
      daily = res;
      return daily;
    } else {
      return null;
      
    }
  }
}

class ProvinceProvider with ChangeNotifier {
  
  DetailCountry province;

  Future<DetailCountry> getProviceProvider(String id) async {
    final response = await http.get("$api/api/countries/$id");
    if (response.statusCode == 200) {
      notifyListeners();
      var res = detailCountryFromJson(response.body);
      province = res;
      return province;
    } else {
      return null;
    }
  }
}