import 'package:flutter/material.dart';

import './key_and_time.dart';
import '../helpers/db_helper.dart';

class KeyAndTimeProv with ChangeNotifier {
  List<KeyAndTime> _userSpentTimes = [];

  List<KeyAndTime> get userSpentTimes {
    return [..._userSpentTimes];
  }
}
