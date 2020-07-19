import 'package:flutter/material.dart';

import './key_and_item.dart';
import '../helpers/db_helper.dart';

class KeyAndItemProv with ChangeNotifier {
  List<KeyAndItem> _userDoneChoices = [];

  List<KeyAndItem> get userDoneChoices {
    return [..._userDoneChoices];
  }

  Future<void> addMap(KeyAndItem newKeyAndItem) async {
    _userDoneChoices.add(newKeyAndItem);
    notifyListeners();
    DBHelper.insert('user_done_choices', {
      'id': newKeyAndItem.id,
      'key': newKeyAndItem.key,
      'items': newKeyAndItem.items.join(','),
    });
  }

  Future<void> fetchAndSetKeyAndItems() async {
    final dataList = await DBHelper.getData('user_done_choices');
    _userDoneChoices = dataList
        .map(
          (item) => KeyAndItem(
            id: item['id'],
            key: item['key'],
            items: item['items'].split(','),
          ),
        )
        .toList();
    notifyListeners();
  }
}
