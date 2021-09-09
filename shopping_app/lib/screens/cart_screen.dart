import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart matte'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total stuff',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalCartAmount}',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Order all the stuff',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
