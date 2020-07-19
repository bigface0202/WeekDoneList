import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/transaction_prov.dart';
// import './screens/tabs_screen.dart';
import './screens/index_screen.dart';
import './screens/make_new_list_screen.dart';
import './screens/new_transaction_screen.dart';
import './models/key_and_item_prov.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => KeyAndItemProv(),
        ),
        ChangeNotifierProxyProvider<KeyAndItemProv, TransactionProv>(
          update: (ctx, keyitem, tx) =>
              TransactionProv(keyitem.userDoneChoices),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        // home: IndexScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => IndexScreen(),
          MakeNewListScreen.routeName: (ctx) => MakeNewListScreen(),
          NewTransactionScreen.routeName: (ctx) => NewTransactionScreen(),
        },
      ),
    );
  }
}
