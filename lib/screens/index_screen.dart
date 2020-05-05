import 'package:flutter/material.dart';

import '.././models/key_and_item.dart';
import '.././widgets/main_drawer.dart';
import '.././models/transaction.dart';
import '.././transactions_list.dart';
import '.././new_transaction.dart';

class IndexScreen extends StatefulWidget {
  final List<Transaction> userTransactions;
  final List<KeyAndItem> userDoneChoices;
  IndexScreen(this.userTransactions, this.userDoneChoices);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  void _addNewTransactions(String txTitle, String txSubTitle,
      double txSpentTime, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      subTitle: txSubTitle,
      spentTime: txSpentTime,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      widget.userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransactions, widget.userDoneChoices),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TransactionsList(widget.userTransactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
