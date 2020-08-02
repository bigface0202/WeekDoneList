import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoneChoicesList extends StatelessWidget {
  final String id;
  final String listKey;
  final List items;

  DoneChoicesList(this.id, this.listKey, this.items);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(listKey),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
              color: Colors.green,
            ),
            IconButton(
                icon: Icon(Icons.delete), onPressed: () {}, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
