import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './key_and_item_prov.dart';
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
    Transaction(
      id: 't2',
      title: 'Sports',
      subTitle: 'Soccer',
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

  void removeTransaction(String id){
    final exsistingTransactionIndex = _userTransactions.indexWhere((tx) => tx.id == id);
    _userTransactions.removeAt(exsistingTransactionIndex);
    notifyListeners();
  }

  void sumSpendTime(){
    double totalSpentTime = 0.0;
    List<Map<String, double>> spentTimeList = [];

    for (var i = 0; i < _userTransactions.length; i++){
      if(_userTransactions[i].title == 'Sports'){
        totalSpentTime += _userTransactions[i].spentTime;
      }
    }
  }
}
