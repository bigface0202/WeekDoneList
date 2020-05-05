import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  String subTitle;
  double spentTime;
  DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.subTitle,
    @required this.spentTime,
    @required this.date,
  });
}
