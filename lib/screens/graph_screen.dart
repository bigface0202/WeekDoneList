import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../models/key_and_time.dart';
import '../models/transaction_prov.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionProv>(context);
    List<charts.Series<KeyAndTime, String>> _createSampleData() {
      return [
        new charts.Series<KeyAndTime, String>(
          id: 'Key',
          domainFn: (KeyAndTime keyandtime, _) => keyandtime.key,
          measureFn: (KeyAndTime keyandtime, _) => keyandtime.sumTime,
          data: transaction.sumSpendTime,
          labelAccessorFn: (KeyAndTime row, _) => '${row.key}: ${row.sumTime}',
        )
      ];
    }

    return transaction.sumSpendTime.length == 0
        ? Container()
        : Container(
            // child: Text(transaction.sumSpendTime()[0].key),
            padding: EdgeInsets.all(60),
            child: charts.PieChart(
              _createSampleData(),
              animate: true,
              defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 100,
                arcRendererDecorators: [
                  new charts.ArcLabelDecorator(
                    insideLabelStyleSpec:
                        new charts.TextStyleSpec(fontSize: 15),
                    outsideLabelStyleSpec:
                        new charts.TextStyleSpec(fontSize: 15),
                  )
                ],
              ),
            ),
          );
  }
}
