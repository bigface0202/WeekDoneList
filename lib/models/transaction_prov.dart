import 'package:flutter/material.dart';

import './key_and_item.dart';
import './transaction.dart';
import './key_and_time.dart';

class TransactionProv with ChangeNotifier {
  List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Training',
      subTitle: 'Back',
      spentTime: 2,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Coding',
      subTitle: 'Flutter',
      spentTime: 2,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Coding',
      subTitle: 'Flutter',
      spentTime: 3,
      date: DateTime.now(),
    ),
  ];

  final List<KeyAndItem> keyAndItemList;
  
  TransactionProv(this.keyAndItemList);
  

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

  void removeTransaction(String id) {
    final exsistingTransactionIndex =
        _userTransactions.indexWhere((tx) => tx.id == id);
    _userTransactions.removeAt(exsistingTransactionIndex);
    notifyListeners();
  }

  sumSpendTime() {
    // double totalSpentTime = 0.0;
    List<KeyAndTime> _spentTimeList = [];

    for (var i = 0; i < keyAndItemList.length; i++) {
      double _sumTime = 0;
      for (var j = 0; j < _userTransactions.length; j++) {
        if (keyAndItemList[i].key == _userTransactions[j].title) {
          _sumTime += _userTransactions[j].spentTime;
        }
      }
      _spentTimeList.add(KeyAndTime(key:keyAndItemList[i].key, sumTime: _sumTime));
    }

    // Sort
    // If you change the order of a and b, you can change ascending and descending.
    _spentTimeList.sort((a, b) => b.sumTime.compareTo(a.sumTime));
    return _spentTimeList;
  }
}
