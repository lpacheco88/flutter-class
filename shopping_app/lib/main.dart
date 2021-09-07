import 'package:flutter/material.dart';
import 'package:shopping_app/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Dummy',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.yellow,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewScreen(),
    );
  }
}
