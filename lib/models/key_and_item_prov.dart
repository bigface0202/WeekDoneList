import 'package:flutter/material.dart';

import './key_and_item.dart';

class KeyAndItemProv with ChangeNotifier {
  List<KeyAndItem> _userDoneChoices = [
    KeyAndItem(
      id: 'k1',
      key: 'Training',
      items: ['Chest', 'Back', 'Legs'],
    ),
    KeyAndItem(
      id: 'k2',
      key: 'Study',
      items: ['Math', 'English', 'Science'],
    ),
    KeyAndItem(
      id: 'k3',
      key: 'Coding',
      items: ['Flutter', 'Python', 'C#'],
    ),
  ];

  List<KeyAndItem> get userDoneChoices {
    return [..._userDoneChoices];
  }

  void addMap(String keyName, List<String> itemList) {
    final newKeyAndItems = KeyAndItem(
      id: DateTime.now().toString(),
      key: keyName,
      items: itemList,
    );

    _userDoneChoices.add(newKeyAndItems);
    notifyListeners();
  }
}
