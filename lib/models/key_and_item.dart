import 'package:flutter/foundation.dart';

class KeyAndItem with ChangeNotifier{
  String id;
  String key;
  List<String> items;
  
  KeyAndItem({
    @required this.id,
    @required this.key,
    @required this.items,
  });
}
