import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../models/key_and_time.dart';
import '../models/key_and_item_prov.dart';
import '../models/transaction_prov.dart';
// import 'package:provider/provider.dart';

// import '../models/transaction_prov.dart';
// import '../models/key_and_item_prov.dart';

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class GraphScreen extends StatelessWidget {
  /// Create one series with sample hard coded data.

  GraphScreen();

  /// Creates a [PieChart] with sample data and no transition.
  // factory GraphScreen.withSampleData() {
  //   return new GraphScreen(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final keys = Provider.of<KeyAndItemProv>(context);
    final transaction = Provider.of<TransactionProv>(context);
    List<charts.Series<KeyAndTime, String>> _createSampleData() {
      // final data = [
      //   new LinearSales(0, 100),
      //   new LinearSales(1, 75),
      //   new LinearSales(2, 25),
      //   new LinearSales(3, 5),
      // ];

      return [
        new charts.Series<KeyAndTime, String>(
          id: 'Sales',
          domainFn: (KeyAndTime sales, _) => sales.key,
          measureFn: (KeyAndTime sales, _) => sales.sumTime,
          data: transaction.sumSpendTime(keys.userDoneChoices),
          // Set a label accessor to control the text of the arc label.
          labelAccessorFn: (KeyAndTime row, _) => '${row.key}: ${row.sumTime}',
        )
      ];
    }

    return Container(
      padding: EdgeInsets.all(60),
      child: charts.PieChart(
        _createSampleData(),
        animate: true,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 100,
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
              insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 15),
              outsideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
