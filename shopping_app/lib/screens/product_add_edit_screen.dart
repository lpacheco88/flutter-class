import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/models/product.dart';

class ProductAddEditScreen extends StatefulWidget {
  static const routeName = 'product-add-edit';
  @override
  _ProductAddEditScreenState createState() => _ProductAddEditScreenState();
}

class _ProductAddEditScreenState extends State<ProductAddEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedOrAddedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0.00,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _submitForm() {
    _form.currentState.save();
    print(_editedOrAddedProduct.title);
    print(_editedOrAddedProduct.description);
    print(_editedOrAddedProduct.price);
    print(_editedOrAddedProduct.imageUrl);
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit or add '),
        actions: <Widget>[
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedOrAddedProduct = Product(
                    title: value,
                    price: _editedOrAddedProduct.price,
                    description: _editedOrAddedProduct.description,
                    imageUrl: _editedOrAddedProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedOrAddedProduct = Product(
                    title: _editedOrAddedProduct.title,
                    price: double.parse(value),
                    description: _editedOrAddedProduct.description,
                    imageUrl: _editedOrAddedProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedOrAddedProduct = Product(
                    title: _editedOrAddedProduct.title,
                    price: _editedOrAddedProduct.price,
                    description: value,
                    imageUrl: _editedOrAddedProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter the url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (value) {
                        _editedOrAddedProduct = Product(
                          title: _editedOrAddedProduct.title,
                          price: _editedOrAddedProduct.price,
                          description: _editedOrAddedProduct.description,
                          imageUrl: value,
                          id: null,
                        );
                      },
                      onFieldSubmitted: (_) {
                        _submitForm();
                      },
                      onEditingComplete: () {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
