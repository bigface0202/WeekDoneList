import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './key_and_item.dart';
import './transaction.dart';
import './key_and_time.dart';
import '../helpers/db_helper.dart';

class TransactionProv with ChangeNotifier {
  List<Transaction> _userTransactions = [];
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
    DBHelper.insert('user_transactions', {
      'id': transaction.id,
      'title': transaction.title,
      'subtitle': transaction.subTitle,
      'spent_time': transaction.spentTime,
      'date': transaction.date.toString(),
    });
  }

  void removeTransaction(String id) {
    final exsistingTransactionIndex =
        _userTransactions.indexWhere((tx) => tx.id == id);
    _userTransactions.removeAt(exsistingTransactionIndex);
    notifyListeners();
    DBHelper.delete('user_transactions', id);
  }

  Future<void> fetchAndSetTransactions() async {
    final dataList = await DBHelper.getData('user_transactions');
    _userTransactions = dataList
        .map(
          (item) => Transaction(
              id: item['id'],
              title: item['title'],
              subTitle: item['subtitle'],
              spentTime: item['spent_time'],
              date: DateTime.parse(item['date'])),
        )
        .toList();
    notifyListeners();
  }

  List<KeyAndTime> get sumSpendTime {
    List<KeyAndTime> _spentTimeList = [];
    for (var i = 0; i < keyAndItemList.length; i++) {
      double _sumTime = 0;
      for (var j = 0; j < _userTransactions.length; j++) {
        if (keyAndItemList[i].key == _userTransactions[j].title) {
          _sumTime += _userTransactions[j].spentTime;
        }
      }
      _spentTimeList
          .add(KeyAndTime(key: keyAndItemList[i].key, sumTime: _sumTime));
    }

    // Sort
    // If you change the order of a and b, you can change ascending and descending.
    _spentTimeList.sort((a, b) => b.sumTime.compareTo(a.sumTime));
    return _spentTimeList;
  }
}
