import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_done_list/models/key_and_item.dart';

import '.././widgets/main_drawer.dart';
import '../models/key_and_item_prov.dart';

class MakeNewListScreen extends StatefulWidget {
  static const routeName = '/make-new-list';
  @override
  _MakeNewListScreenState createState() => _MakeNewListScreenState();
}

class _MakeNewListScreenState extends State<MakeNewListScreen> {
  final _newListController = TextEditingController();
  final _itemNumController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedKeyAndItem = KeyAndItem(
    id: null,
    key: '',
    items: new List<String>(),
  );
  var _initKeyAndItems = {
    'key': '',
    'items': '',
  };
  var _isLoading = false;
  int _itemNum = 0;

  @override
  void dispose() {
    _newListController.dispose();
    _itemNumController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<KeyAndItemProv>(context, listen: false)
          .addMap(_editedKeyAndItem);
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occured!'),
          content: Text('Something went wrong'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make new list'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: SingleChildScrollView(
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
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'New key name'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedKeyAndItem.key = value;
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'How many items?'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(
                                  () {
                                    _itemNum = int.parse(value);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return TextFormField(
                              initialValue: _initKeyAndItems['items'],
                              decoration: InputDecoration(
                                  labelText: 'Item ${index + 1}'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedKeyAndItem.items.add(value);
                                _editedKeyAndItem = KeyAndItem(
                                  id: _editedKeyAndItem.id,
                                  key: _editedKeyAndItem.key,
                                  items: _editedKeyAndItem.items,
                                );
                              },
                            );
                          },
                          itemCount: _itemNum,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
