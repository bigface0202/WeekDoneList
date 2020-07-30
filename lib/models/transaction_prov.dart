import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './transaction.dart';
import './key_and_time.dart';
import '../helpers/db_helper.dart';

class TransactionProv with ChangeNotifier {
  List<Transaction> _userTransactions = [];

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
    // タイトル毎に使った時間のリスト
    List<KeyAndTime> _spentTimeList = [];
    // タイトルのリストを作成
    List titleList = [];
    for (var i = 0; i < _userTransactions.length; i++) {
      titleList.add(_userTransactions[i].title);
    }
    // 重複するタイトルを削除
    titleList = titleList.toSet().toList();
    for (var i = 0; i < titleList.length; i++) {
      double _sumTime = 0;
      for (var j = 0; j < _userTransactions.length; j++) {
        if (titleList[i] == _userTransactions[j].title) {
          _sumTime += _userTransactions[j].spentTime;
        }
      }
      _spentTimeList.add(KeyAndTime(key: titleList[i], sumTime: _sumTime));
    }
    // Sort: If you change the order of a and b, you can change ascending and descending.
    _spentTimeList.sort((a, b) => b.sumTime.compareTo(a.sumTime));
    return _spentTimeList;
  }
}
