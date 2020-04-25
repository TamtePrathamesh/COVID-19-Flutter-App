import 'dart:async';
import 'dart:convert';
import 'package:challenge3/models/ContryLatLong.dart';
import 'package:challenge3/models/CountryStats.dart';
import 'package:challenge3/models/CovidTrackerModel.dart';
import 'package:challenge3/models/CtLatLngR.dart';
import 'package:challenge3/models/IndiaStateData.dart';
import 'package:http/http.dart' as http;


class Services {

 String baseUrl = 'https://covid19.mathdro.id/';


   static Future<List<CountriesLatLong>> getMyCt() async {
    String url = "https://coronavirus-tracker-api.herokuapp.com/v2/locations";
    final response=await http.get(url);
    final res=jsonDecode(response.body);
    return (res["locations"] as List).map<CountriesLatLong>((json) => CountriesLatLong.fromJson(json))
        .toList();

  }

  

  static Future<List<CountriesStats>> getCountriesStats() async {
    String url =
        "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php";
    
      Map<String, String> requestHeaders = {
       "x-rapidapi-host": "coronavirus-monitor-v2.p.rapidapi.com",
	"x-rapidapi-key": "your_keys"
      };
        final response = await http.get(url, headers: requestHeaders);
         final res= jsonDecode(response.body);
        return (res["countries_stat"] as List).map<CountriesStats>((json) => CountriesStats.fromJson(json))
        .toList();
     
     
  }
   
  static Future<List<CtLatLngR>> getCtLatLng() async {
   String url = "https://covid19-data.p.rapidapi.com/all";
       Map<String, String> requestHeaders = {
       "x-rapidapi-host": "covid19-data.p.rapidapi.com",
	"x-rapidapi-key": "your_keys"
      };
    final response=await http.get(Uri.encodeFull(url),headers: requestHeaders);
    final res=jsonDecode(response.body);
    return (res as List).map<CtLatLngR>((json) => CtLatLngR.fromJson(json))
        .toList();

  }

  static Future<List<CovidTrackerModel>> getCovidDataMath() async {
   String api="https://covid19.mathdro.id";
      
    final response=await http.get(Uri.encodeFull("$api/api"));
    final res=jsonDecode(response.body);
    return (res as List).map<CovidTrackerModel>((json) => CovidTrackerModel.fromJson(json))
        .toList();

  }


  static Future<List<IndiaStateData>> getINStateData() async {
   String api="https://covid19india.p.rapidapi.com/getIndiaStateData";
    Map<String, String> requestHeaders = {
       "x-rapidapi-host": "covid19india.p.rapidapi.com",
	"x-rapidapi-key": "your_keys"
      };
      
     final response=await http.get(Uri.encodeFull(api),headers: requestHeaders);
    final res=jsonDecode(response.body);
    return (res["response"] as List).map<IndiaStateData>((json) => IndiaStateData.fromJson(json))
        .toList();

  }
  
  
  


}