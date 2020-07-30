import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/key_and_item_prov.dart';
import '../models/transaction.dart';
import '../models/transaction_prov.dart';

class NewTransactionScreen extends StatefulWidget {
  static const routeName = '/new-transaction';
  @override
  _NewTransactionScreenState createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  // final _titleController = TextEditingController();
  final _spentTimeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedKey;
  int _selectedKeyNum;
  String _selectedItem;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<KeyAndItemProv>(context).fetchAndSetKeyAndItems().then((_) {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _spentTimeController.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_spentTimeController.text.isEmpty) {
      return;
    }
    final enteredItem = _selectedItem;
    final enteredTitle = _selectedKey;
    final enteredSpentTime = double.parse(_spentTimeController.text);

    if (enteredTitle.isEmpty || enteredSpentTime < 0 || _selectedDate == null) {
      return;
    }

    final newTx = Transaction(
      title: enteredTitle,
      subTitle: enteredItem,
      spentTime: enteredSpentTime,
      date: _selectedDate,
      id: DateTime.now().toString(),
    );
    Provider.of<TransactionProv>(context, listen: false).addTransaction(newTx);
    // 戻る遷移（pushで進む）
    // この場合だと元の画面に戻る
    Navigator.of(context).pushNamed('/');
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyAndItem = Provider.of<KeyAndItemProv>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, '/');
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                Navigator.of(context).pushNamed('/');
              }),
          title: Text(
            "Add new done thing! Congrats!",
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('What did you do?'),
                        DropdownButton<String>(
                          value: _selectedKey,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          elevation: 16,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedKey = newValue;
                              _selectedKeyNum = keyAndItem.userDoneChoices
                                  .indexWhere((userDoneChoices) =>
                                      userDoneChoices.key == newValue);
                              _selectedItem = null;
                            });
                          },
                          items: keyAndItem.userDoneChoices
                              .map((tx) => DropdownMenuItem(
                                  value: tx.key, child: Text(tx.key)))
                              .toList(),
                        ),
                      ],
                    ),
                    _selectedKeyNum != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Which one?'),
                              DropdownButton<String>(
                                value: _selectedItem,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                elevation: 16,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                underline: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedItem = newValue;
                                  });
                                },
                                items: keyAndItem
                                    .userDoneChoices[_selectedKeyNum].items
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          )
                        : Container(),
                    TextField(
                      decoration: InputDecoration(labelText: 'Spent time'),
                      keyboardType: TextInputType.number,
                      controller: _spentTimeController,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Chosen date: ${DateFormat.yMMMd().format(_selectedDate)}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Change date'),
                      onPressed: _presentDatePicker,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Submit!'),
                      onPressed: _submitData,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
