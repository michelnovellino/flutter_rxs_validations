import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forms_validations/src/models/product.model.dart';
import 'package:forms_validations/src/providers/product.provider.dart';
import 'package:forms_validations/src/utils/validation.utils.dart'
    as validations;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = ProductsProvider();
  ProductModel productModel = ProductModel();
  bool _isSubmit = false;
  File _photo;
  @override
  Widget build(BuildContext context) {
    final ProductModel props = ModalRoute.of(context).settings.arguments;

    if (props != null) {
      productModel = props;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('ProductPage'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _pickImage,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takeImage,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _showImage(),
                _inputName(),
                _inputPrice(),
                _inputAvaliable(),
                _submit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputName() {
    return TextFormField(
      initialValue: productModel.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product name'),
      onSaved: (value) {
        return productModel.title = value;
      },
      validator: (value) {
        if (value.length < 5) {
          return 'min length 5 characters';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputPrice() {
    return TextFormField(
      initialValue: productModel.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Product Price'),
      onSaved: (value) {
        return productModel.price = double.parse(value);
      },
      validator: (value) {
        if (validations.isNum(value)) {
          return null;
        } else {
          return 'only numbers';
        }
      },
    );
  }

  Widget _inputAvaliable() {
    return SwitchListTile(
      value: productModel.avaliable,
      title: Text('Its avaliable'),
      onChanged: (value) {
        setState(() {
          productModel.avaliable = value;
        });
      },
    );
  }

  Widget _showImage() {
    if (productModel.photoUrl != null) {
      return FadeInImage(
        height: 280,
        fit: BoxFit.contain,
        image: NetworkImage(productModel.photoUrl),
        placeholder: AssetImage('assets/images/jar-loading.gif'),
      );
    } else {
      return Image(
        image: AssetImage(_photo?.path ?? 'assets/images/no-image.png'),
        height: 300,
        fit: BoxFit.fill,
      );
    }
  }

  _takeImage() async {
    _imageMiddleware(ImageSource.camera);
  }

  _pickImage() async {
    _imageMiddleware(ImageSource.gallery);
  }

  _imageMiddleware(ImageSource image) async {
    _photo = await ImagePicker.pickImage(source: image);
    if (_photo != null) {
      productModel.photoUrl = null;
    }
    setState(() {});
  }

  Widget _submit() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        label: Text('Save'),
        icon: Icon(Icons.save),
        onPressed: (_isSubmit) ? null : _onSubmit,
      ),
    );
  }

  void _onSubmit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _isSubmit = true;
    });

    if (_photo != null) {
      productModel.photoUrl = await productProvider.upload(_photo);
    }

    if (productModel.id == null) {
      productModel.photoUrl = await productProvider.upload(_photo);

      productProvider.add(productModel);
    } else {
      productModel.photoUrl = await productProvider.upload(_photo);

      productProvider.edit(productModel);
    }

    _snackbar('Saved');
    setState(() {
      _isSubmit = false;
    });
  }

  void _snackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
