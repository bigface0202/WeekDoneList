import 'package:flutter/material.dart';
import 'package:week_done_list/screens/tabs_screen.dart';

import './screens/index_screen.dart';
import './screens/make_new_list_screen.dart';
import './models/transaction.dart';
import './models/key_and_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _userTransactions = [
  ];

  final List<KeyAndItem> _userDoneChoices = [
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

  void _addNewMap(String keyName, List<String> itemList) {
    final newKeyAndItems = KeyAndItem(
      id: DateTime.now().toString(),
      key: keyName,
      items: itemList,
    );

    setState(() {
      _userDoneChoices.add(newKeyAndItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_userTransactions, _userDoneChoices),
        MakeNewListScreen.routeName: (ctx) => MakeNewListScreen(_addNewMap),
      },
    );
  }
}
