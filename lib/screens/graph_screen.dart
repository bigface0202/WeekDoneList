import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:week_done_list/models/key_and_item_prov.dart';

import '../models/key_and_time.dart';
import '../models/transaction_prov.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  // @override
  // void initState() {
  //   print("init!");
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   Future.delayed(Duration.zero).then((_) {
  //     Provider.of<KeyAndItemProv>(context, listen: false)
  //         .fetchAndSetKeyAndItems();
  //   });
  //   print('change!');
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionProv>(context);
    // // print(transaction.userTransactions.length);
    // List<charts.Series<KeyAndTime, String>> _createSampleData() {
    //   return [
    //     new charts.Series<KeyAndTime, String>(
    //       id: 'Key',
    //       domainFn: (KeyAndTime keyandtime, _) => keyandtime.key,
    //       measureFn: (KeyAndTime keyandtime, _) => keyandtime.sumTime,
    //       data: transaction.sumSpendTime(),
    //       // Set a label accessor to control the text of the arc label.
    //       labelAccessorFn: (KeyAndTime row, _) => '${row.key}: ${row.sumTime}',
    //     )
    //   ];
    // }
    //sumSpendTimeを実行するには、KeyAndItemProvのfetchを実行する必要がある
    return Container(
      child: Text(transaction.sumSpendTime()[0].key),
      // padding: EdgeInsets.all(60),
      // child: charts.PieChart(
      //   _createSampleData(),
      //   animate: true,
      //   defaultRenderer: new charts.ArcRendererConfig(
      //     arcWidth: 100,
      //     arcRendererDecorators: [
      //       new charts.ArcLabelDecorator(
      //         insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 15),
      //         outsideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 15),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
