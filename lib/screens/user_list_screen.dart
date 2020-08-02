import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_done_list/models/key_and_item.dart';
import 'package:week_done_list/models/key_and_item_prov.dart';
import 'package:week_done_list/screens/make_new_list_screen.dart';
import 'package:week_done_list/widgets/done_choices_list.dart';
import 'package:week_done_list/widgets/main_drawer.dart';

class UserListScreen extends StatelessWidget {
  static const routeName = '/user-list-screen';
  Future<void> _refreshList(BuildContext context) async {
    await Provider.of<KeyAndItemProv>(context, listen: false)
        .fetchAndSetKeyAndItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your List'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(MakeNewListScreen.routeName);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
          future: _refreshList(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshList(context),
                      child: Consumer<KeyAndItemProv>(
                        builder: (ctx, listData, _) => Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemCount: listData.userDoneChoices.length,
                            itemBuilder: (_, i) => Column(
                              children: <Widget>[
                                DoneChoicesList(
                                    listData.userDoneChoices[i].id,
                                    listData.userDoneChoices[i].key,
                                    listData.userDoneChoices[i].items),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
