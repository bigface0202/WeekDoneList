import 'package:flutter/foundation.dart';

class KeyAndTime with ChangeNotifier{
  String key;
  double sumTime;

  KeyAndTime({
    @required this.key,
    @required this.sumTime,
  });
}
