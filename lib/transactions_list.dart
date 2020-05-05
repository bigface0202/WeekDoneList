import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FittedBox(
                    child: Text(
                  '${transactions[index].spentTime} h',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${transactions[index].subTitle}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('${transactions[index].title}',
                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            subtitle: Text(
              DateFormat.yMMMMEEEEd().format(transactions[index].date),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
