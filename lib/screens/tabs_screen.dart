import 'package:flutter/material.dart';

import './graph_screen.dart';
import './index_screen.dart';
import '.././widgets/main_drawer.dart';
import '../models/transaction.dart';
import '../models/key_and_item.dart';

class TabsScreen extends StatefulWidget {
  final List<Transaction> userTransactions;
  final List<KeyAndItem> userDoneChoices;
  TabsScreen(this.userTransactions, this.userDoneChoices);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': IndexScreen(widget.userTransactions, widget.userDoneChoices),
        'title': 'Week Done List',
      },
      {
        'page': GraphScreen(),
        'title': 'Week Done Graph',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          unselectedItemColor: Colors.black26,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.check_box),
              title: Text('Week Done List'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.insert_chart),
              title: Text('Week Done Graph'),
            )
          ]),
    );
  }
}
