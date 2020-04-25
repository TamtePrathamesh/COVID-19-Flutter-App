import 'dart:async';
import 'package:challenge3/ConnectivityCheck.dart';
import 'package:challenge3/Service/Services.dart';
import 'package:challenge3/models/CountryStats.dart';
import 'package:challenge3/models/CtLatLngR.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/services.dart';



class CMyMaps extends StatefulWidget {
  @override
  _MyMapsState createState() => _MyMapsState();
}

class _MyMapsState extends State<CMyMaps> {

  
  List<CtLatLngR>myct_latlong;
  List<CountriesStats>ct_stats;
  final Map<String, Marker> _markers = {};

 static LatLng _center = const LatLng(21.7679, 78.8718);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers;
  MapType type;
  ProgressDialog pr;
   LatLng _lastMapPosition = _center;
  


    void mybottomSheet(CtLatLngR cs,CountriesStats cl){
      showModalBottomSheet(context: context, builder: (BuildContext context){
        return ListView(
          children: <Widget>[
             ListTile(
               leading: Image.asset("assets/icon/virus.png",width: 25,height: 25,),
              title: Text(cs.country,style:TextStyle(fontSize: 25,fontWeight: FontWeight.w500,),),
             
            ),
            ListTile(
              title: Text("Confirmed Cases",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.blue),),
              subtitle: Text(cs.confirmed.toString(),style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blue),),
            ),
            ListTile(
              title: Text("Recovered Cases",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.green),),
              subtitle: Text(cs.recovered.toString(),style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.green),),
            ),
            ListTile(
              title: Text("Death Cases",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.red),),
              subtitle: Text(cs.deaths.toString(),style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.red),),
            ),
             ListTile(
              title: Text("New Cases",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500,),),
              subtitle: Text(cl.new_cases,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,),),
            ),
            ListTile(
              title: Text("New Death Cases",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500,),),
              subtitle: Text(cl.new_deaths,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,),),
            ),

          ],
        );
      });
    }
  
  Future<void> setMarker(List<CtLatLngR> countriesLatLng,List<CountriesStats> ct_stats) async {

      _markers.clear();
    for (var c1 in countriesLatLng) {
      for(var c2 in ct_stats){
        if(c1.country.contains(c2.country_name)){
           try {
        var addresses =
            await Geocoder.local.findAddressesFromQuery(c1.country);
        var first = addresses.first;
        final marker = new Marker(
          markerId: MarkerId(c2.country_name),
          position:
              LatLng(first.coordinates.latitude, first.coordinates.longitude),
          infoWindow: InfoWindow(
            title: c1.country,
            snippet: "Total Cases :- ${c1.confirmed}",
            onTap: () {
            
              mybottomSheet(c1, c2);
            },
          ),
          onTap: () {
          
             mybottomSheet(c1, c2);
          },
        );
         if(this.mounted){
            setState(() {
              _markers[c1.country] = marker;
          });
         }
      } on PlatformException {}
        }
      }
     
    }
 if(this.mounted){
    setState(() {
     resetCamera(LatLng(20.5937, 78.9629), 3);
  });
 }
  
  if(this.mounted){
 setState(() {
      resetCamera(LatLng(20.5937, 78.9629), 3);
    });
  }
   
  }
   Future<void> resetCamera(LatLng latLng, double zoom) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, tilt: 50, zoom: zoom, bearing: 15.0)));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     type = MapType.normal;
    markers = Set.from([]);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
      message: "Loading Map..."
    );

   getData();
       
  }


  Future<List<CtLatLngR>>getctlatlanglist()async{
    List<CtLatLngR>ls=await Services.getCtLatLng();
    return ls;
  }
   Future<List<CountriesStats>>getctmystats()async{
    List<CountriesStats>cs=await Services.getCountriesStats();
    return cs;
  }
    
  Future<void>getData()async{
     CheckConnectivity.isConnected().then((isconnected) async {
      if(isconnected){
         if(this.mounted){
             pr.show();
             List<CtLatLngR>l1=await getctlatlanglist();
               List<CountriesStats>l2=await getctmystats();
             setMarker(l1,l2);
             if(this.mounted){
               setState(() {
                 resetCamera(LatLng(20.5937, 78.9629), 3);
             });
             }
             pr.dismiss();
       
      }else{
        CheckConnectivity.showInternetDialog(context);
      }
    }});
  }
 

void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "COVID-19 Affected Cities",
            style: TextStyle(
                fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.green[700],
        ),
      body: Stack(
          children: <Widget>[
            GoogleMap(
             markers: _markers.values.toSet(),
              mapType: type,
             onCameraMove: _onCameraMove,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _controller.complete(controller);
                });
              },
              
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(target: _center, zoom: 6.0),
              myLocationEnabled: true,
              onTap: (position) {
                Marker mk1 = Marker(
                  markerId: MarkerId('1'),
                  position: position,
                );
                setState(() {
                  markers.add(mk1);
                });
                print("tapped" +
                    position.latitude.toString() +
                    " " +
                    position.longitude.toString());
              },
            ),
          
          ],
        ),
    );
  }
}