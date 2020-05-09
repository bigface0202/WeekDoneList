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
        return Dismissible(
          key: ValueKey(transactions[index].id),
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(Icons.delete, color: Colors.white, size: 40),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
          ),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text(
                  'Do you want to remove the item from the cart?',
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false); //Comes back
                    },
                  ), //Dont continue
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true); //Go on
                    },
                  ),
                ],
              ),
            );
          }, //消す前に確認できる
          onDismissed: (direction) {
            //トランザクションから消す処理
          },
          child: Card(
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
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              subtitle: Text(
                DateFormat.yMMMMEEEEd().format(transactions[index].date),
              ),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
