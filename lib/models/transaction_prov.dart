import 'package:flutter/material.dart';

import './transaction.dart';

class TransactionProv with ChangeNotifier {
  List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Sports',
      subTitle: 'Baseball',
      spentTime: 2,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get userTransactions {
    return [..._userTransactions];
  }

  void addTransaction(Transaction transaction) {
    final newTransaction = Transaction(
      id: transaction.id,
      title: transaction.title,
      subTitle: transaction.subTitle,
      spentTime: transaction.spentTime,
      date: transaction.date,
    );
    _userTransactions.add(newTransaction);
    notifyListeners();
  }
}
