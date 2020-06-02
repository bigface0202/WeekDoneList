import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/transactions_list.dart';
import '../models/transaction_prov.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FutureBuilder(
              future: Provider.of<TransactionProv>(context, listen: false)
                  .fetchAndSetTransactions(),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : TransactionsList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).pushNamed('/new-transaction');
        },
      ),
    );
  }
}
