import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/screens/product_add_edit_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imgUrl,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ProductAddEditScreen.routeName, arguments: id);
              },
              icon: Icon(Icons.edit),
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {
                Provider.of<Products>(
                  context,
                  listen: false,
                ).deleteProduct(id);
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
