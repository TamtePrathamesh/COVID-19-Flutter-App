
import 'package:challenge3/Service/CovidTrackerService.dart';
import 'package:challenge3/models/detail_country.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

// class PieCard extends StatelessWidget {
// //  final Covid model;
 
//  // PieCard({this.model});

// }

class LinearCovid {
  final String legendText;
  final int data;

  LinearCovid(this.legendText, this.data);
}


class GlobalDrawPieChart extends StatefulWidget {
 final DetailCountry model;

  
 
 GlobalDrawPieChart({this.model});
  final data = [ 
  ];
 
  @override
  _GlobalDrawPieChartState createState() => _GlobalDrawPieChartState();
}

class _GlobalDrawPieChartState extends State<GlobalDrawPieChart> {

   void addData(DetailCountry dc){
data.add( LinearCovid('Confirmed',int.parse(dc.confirmed.value.toString())));
    data.add(  LinearCovid('Recovered',int.parse(dc.recovered.value.toString())));
    data.add(  LinearCovid('Deaths',int.parse(dc.deaths.value.toString())));
  }
  final data = [ LinearCovid('Confirmed',0),
   LinearCovid('Recovered',0),
   LinearCovid('Deaths',0)];
  bool adding=true;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.clear();
    data.add( LinearCovid('Confirmed',int.parse(widget.model.confirmed.value.toString())));
    data.add(  LinearCovid('Recovered',int.parse(widget.model.recovered.value.toString())));
    data.add(  LinearCovid('Deaths',int.parse(widget.model.deaths.value.toString())));

     setState(() {
      adding=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    var province = Provider.of<ProvinceProvider>(context).province;
     data.clear();
    data.add( LinearCovid('Confirmed',int.parse(province.confirmed.value.toString())));
    data.add(  LinearCovid('Recovered',int.parse(province.recovered.value.toString())));
    data.add(  LinearCovid('Deaths',int.parse(province.deaths.value.toString())));
    final height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: Color(0xff1b232f),
            borderRadius: BorderRadius.circular(10.0)),
        height: height * 0.45,
        child: charts.PieChart(
          adding?[]: [
      new charts.Series<LinearCovid, String>(
        id: 'covid-19',
        outsideLabelStyleAccessorFn: (LinearCovid l, _) => charts.TextStyleSpec(
          color: charts.Color(r: 255, g: 255, b: 255),
        ),
        colorFn: (LinearCovid l, i) {
          if (i == 0) return charts.Color(r: 242, g: 185, b: 3);
          if (i == 1) return charts.Color(r: 0, g: 128, b: 0);
          return charts.Color(r: 255, g: 0, b: 0);
        },
        labelAccessorFn: (LinearCovid l, _) => '',
        // overlaySeries: true,

        insideLabelStyleAccessorFn: (LinearCovid l, _) =>
            charts.TextStyleSpec(color: charts.Color(r: 0, g: 0, b: 0)),
        // fillColorFn: (LinearCovid l, _) =>
        //     charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearCovid l, _) => l.legendText,
        measureFn: (LinearCovid l, _) => l.data,
        data: data,
       
      )
    ],
          animate: true,
          behaviors: [
            charts.DatumLegend(
                position: charts.BehaviorPosition.bottom,
                entryTextStyle: charts.TextStyleSpec(
                    color: charts.Color(r: 255, g: 255, b: 255)))
          ],
          defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 40,
            arcRendererDecorators: [new charts.ArcLabelDecorator()],
          ),
        ));
  }
}