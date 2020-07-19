import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction_prov.dart';

class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProv>(
      child: Container(
        padding: EdgeInsets.only(top: 265, bottom: 265),
        child: Center(
          child: const Text('Nothing you done!'),
        ),
      ),
      builder: (ctx, transactions, ch) => transactions
                  .userTransactions.length <=
              0
          ? ch
          : ListView.builder(
              // ↓がないとスクロールできない
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactions.userTransactions.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: ValueKey(transactions.userTransactions[index].id),
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
                          'Do you want to remove this?',
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
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Delete ${transactions.userTransactions[index].subTitle}, ${DateFormat.yMMMMEEEEd().format(transactions.userTransactions[index].date)}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    Provider.of<TransactionProv>(context, listen: false)
                        .removeTransaction(
                            transactions.userTransactions[index].id);
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
                            '${transactions.userTransactions[index].spentTime} h',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${transactions.userTransactions[index].subTitle}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text('${transactions.userTransactions[index].title}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd()
                            .format(transactions.userTransactions[index].date),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
