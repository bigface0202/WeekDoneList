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
  Future _loadingKey;
  @override
  void initState() {
    // _loadingKey = Provider.of<KeyAndItemProv>(context, listen: false)
    //     .fetchAndSetKeyAndItems();
    print("a");
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   _loadingKey = Provider.of<KeyAndItemProv>(context, listen: false)
  //       .fetchAndSetKeyAndItems();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionProv>(context);
    // List graph = transaction.sumSpendTime();
    // 一回目はうまく呼び出されるが、2回目で空になる？
    print(transaction.sumSpendTime.length);

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

    //sumSpendTimeを実行するには、KeyAndItemProvのfetchを実行する必要がある
    // return FutureBuilder(
    //   future: _loadingKey,
    //   builder: (ctx, snapshot) =>
    //       snapshot.connectionState == ConnectionState.waiting
    //           ? Center(
    //               child: CircularProgressIndicator(),
    //             )
    //           :
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
