import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/transaction_prov.dart';
import './screens/tabs_screen.dart';
import './screens/make_new_list_screen.dart';
import './models/key_and_item_prov.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TransactionProv(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => KeyAndItemProv(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        // home: MyHomePage(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          MakeNewListScreen.routeName: (ctx) => MakeNewListScreen(),
        },
      ),
    );
  }
}