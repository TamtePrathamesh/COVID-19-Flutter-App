
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';

class SubscriberChart extends StatelessWidget {
  final List<OrdinalSales> data;

  SubscriberChart({@required this.data});

  @override
Widget build(BuildContext context) {
  List<charts.Series<OrdinalSales, String>> series = [
    charts.Series(
      id: "Subscribers",
      data: data,
      domainFn: (OrdinalSales series, _) => series.state,
      measureFn: (OrdinalSales series, _) => series.confirmed,
      labelAccessorFn: (OrdinalSales sales, _) =>
              '${sales.state}: ${sales.confirmed.toString()}'
     
    )
   ];
   return charts.BarChart(
     series,
     animate: false,
      vertical: false,
            barRendererDecorator: new charts.BarLabelDecorator(
               insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 15),
               outsideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 12,)),
   
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec())
     );
}
}

class OrdinalSales {
  final String state;
  final int confirmed;

  OrdinalSales({@required this.state, @required this.confirmed});
}