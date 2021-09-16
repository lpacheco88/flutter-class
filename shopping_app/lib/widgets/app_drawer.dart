import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/helpers/custom_route.dart';
import 'package:shopping_app/providers/auth.dart';
import 'package:shopping_app/screens/orders_screen.dart';
import 'package:shopping_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hi User!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
            ),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
              // Navigator.of(context).pushReplacement(
              //     CustomRoute(builder: (ctx) => OrdersScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
            ),
            title: Text('Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
            ),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).popAndPushNamed('/');
              Provider.of<Auth>(
                context,
                listen: false,
              ).logout();
            },
          )
        ],
      ),
    );
  }
}
