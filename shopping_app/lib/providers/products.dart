import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopping_app/models/http_exception.dart';
import 'package:shopping_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prd) => prd.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-class-905df-default-rtdb.firebaseio.com/products/$id.json');
      await http.patch(url,
          body: jsonEncode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://flutter-class-905df-default-rtdb.firebaseio.com/products/$id.json');
    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProd);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProd = null;
  }

  Future<void> fetcAndSetProducts() async {
    final url = Uri.parse(
        'https://flutter-class-905df-default-rtdb.firebaseio.com/products.json');
    ;
    try {
      final response = await http.get(url);
      final prdData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> displayProds = [];
      if (prdData == null) {
        return;
      }
      prdData.forEach((prodId, product) {
        displayProds.add(Product(
            id: prodId,
            title: product['title'],
            description: product['description'],
            price: product['price'],
            imageUrl: product['imageUrl'],
            isFavorite: product['isFavorite']));
      });
      _items = displayProds;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-class-905df-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          },
        ),
      );

      final newPrd = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newPrd);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }

    // _items.insert(0, newPrd); //only if insert in the begin of the list would be necessary
  }
}
