import 'package:challenge3/ConnectivityCheck.dart';
import 'package:challenge3/Service/CovidTrackerService.dart';
import 'package:challenge3/widgets/GlobalPieCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CovidTracker extends StatefulWidget {
  @override
  _CovidTrackerState createState() => _CovidTrackerState();
}

class _CovidTrackerState extends State<CovidTracker> {
  DateFormat fn = DateFormat("M-dd-yyyy");
  String _selectedLocation = "IN";
  String datetime = '2-14-2020';

  bool loading = false;

  List<CovidTrackerService> ct_data;
  List<CovidTrackerCountry> ct_country;
  List<DailyProvider> ct_daily;
  List<ProvinceProvider> ct_provi;

  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
     CheckConnectivity.isConnected().then((isConnected){
      if(!isConnected){
        CheckConnectivity.showInternetDialog(context);
      }
    });

    if(this.mounted){
      setState(() {
      loading = true;
    });
    }
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(message: "fetching data...");
    final now = DateTime.now();
    setState(() {
      datetime = fn.format(DateTime(now.year, now.month, now.day - 1));
    });
    Provider.of<CovidTrackerService>(context, listen: false)
        .getCovidTrackerData();
    Provider.of<CovidTrackerCountry>(context, listen: false)
        .getCountryProvider();
    // Provider.of<DailyProvider>(context, listen: false)
    //     .getDailyProvider(datetime);
    Provider.of<ProvinceProvider>(context, listen: false)
        .getProviceProvider(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat f = DateFormat("yyyy-MM-dd HH:mm:ss");
    final nf = NumberFormat("#,###");
    var home = Provider.of<CovidTrackerService>(context).home;
    //var daily = Provider.of<DailyProvider>(context).daily;
    var province = Provider.of<ProvinceProvider>(context).province;
    var country = Provider.of<CovidTrackerCountry>(context).country;
    if (home != null && province != null && country != null) {
     if(this.mounted){
        setState(() {
        loading = false;
      });
     }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Covid Tracker",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.green[700],
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                )
              : ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Global Stats",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Last Updated:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.timer, color: Colors.cyan),
                            SizedBox(width: 2),
                            Expanded(
                                child: Text(f.format(home?.lastUpdate),
                                    style: TextStyle(color: Colors.black))),
                          ],
                        ),
                        titleWidget(
                            'Confirmed',
                            nf.format(home?.confirmed?.value) ?? '',
                            Colors.black),
                        titleWidget(
                            'Recovered',
                            nf.format(home?.recovered?.value) ?? '',
                            Colors.green),
                        titleWidget('Deaths',
                            nf.format(home?.deaths?.value) ?? '', Colors.red),
                      ],
                    ),
                    SizedBox(height: 20),
                    Card(
                      color: Color(0xff1b232f),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Theme(
                              data: ThemeData(canvasColor: Color(0xff1b232f)),
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                    'Please choose a location',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: _selectedLocation,
                                  onChanged: (newValue) {
                                    print(newValue);
                                    setState(() {
                                      _selectedLocation = newValue;
                                      // subloading=true;
                                    });
                                    Provider.of<ProvinceProvider>(context,
                                            listen: false)
                                        .getProviceProvider(newValue);

                                   
                                  },
                                  items: country.countries
                                      .map((val) => DropdownMenuItem(
                                            value: val.iso2,
                                            child: Text(
                                              val.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ))
                                      .toList()),
                            ),
                          ),
                          confirmDetail(
                            province.confirmed.value != null
                                ? province.confirmed.value.toString()
                                : '',
                            province?.recovered?.value != null
                                ? province?.recovered?.value.toString()
                                : '',
                            province?.deaths?.value != null
                                ? province?.deaths?.value?.toString()
                                : '',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          loading
                              ? Container()
                              : Container(
                                  child: GlobalDrawPieChart(
                                  model: province,
                                ))
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }

  Widget confirmDetail(confirm, recovered, death) {
    setState(() {});
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Confirmed', style: TextStyle(color: Colors.blue)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child:
                    Text(confirm ?? '', style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Recovered', style: TextStyle(color: Colors.green)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(recovered ?? '',
                    style: TextStyle(color: Colors.green)),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Deaths', style: TextStyle(color: Colors.red)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(death ?? '', style: TextStyle(color: Colors.red)),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget titleWidget(title, subtitle, color) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.black)),
      subtitle: Text(subtitle,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
