import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_done_list/models/key_and_item.dart';

import '.././widgets/main_drawer.dart';
import '../models/key_and_item_prov.dart';
import '../models/transaction_prov.dart';

class MakeNewListScreen extends StatefulWidget {
  static const routeName = '/make-new-list';
  @override
  _MakeNewListScreenState createState() => _MakeNewListScreenState();
}

class _MakeNewListScreenState extends State<MakeNewListScreen> {
  final _newListController = TextEditingController();
  final _itemNumController = TextEditingController();
  final List<TextEditingController> _newItemListcontroller = [];

  int _itemNum = 0;

  void _submitNewMap() {
    List<String> array = [];

    final enteredTitle = _newListController.text;
    for (int i = 0; i < _newItemListcontroller.length; i++) {
      array.add(_newItemListcontroller[i].text);
    }
    print(array.join(','));
    final newKeyItem = KeyAndItem(
        id: DateTime.now().toString(), key: enteredTitle, items: array);
    Provider.of<KeyAndItemProv>(context, listen: false).addMap(newKeyItem);
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make new list'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                10, //Get Keyboard height + 10
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Rowの中にTextFieldを作る場合は，横の幅を指定する必要がある
                  // TextField自体が横幅を指定する変数を持っていない
                  // When you make TextField in Row, you should declear the width space of TextField
                  // TextField doesn't have width space.
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'New key name'),
                      keyboardType: TextInputType.text,
                      controller: _newListController,
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'How many items?'),
                      keyboardType: TextInputType.number,
                      controller: _itemNumController,
                      onChanged: (_) {
                        setState(() {
                          _itemNum = int.parse(_itemNumController.text);
                          for (int i = 0; i < _itemNum; i++)
                            _newItemListcontroller.add(TextEditingController());
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  // scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return TextField(
                      decoration: InputDecoration(labelText: 'Item $index'),
                      keyboardType: TextInputType.text,
                      controller: _newItemListcontroller[index],
                    );
                  },
                  itemCount: _itemNum,
                ),
              ),
              _newItemListcontroller.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text(
                              'Submit!',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: _submitNewMap,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
