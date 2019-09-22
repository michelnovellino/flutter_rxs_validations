import 'package:flutter/material.dart';
import 'package:forms_validations/src/models/product.model.dart';
import 'package:forms_validations/src/providers/product.provider.dart';
import 'package:forms_validations/src/providers/provider.dart';

class HomePage extends StatelessWidget {
  final productProvider = ProductsProvider();
  ProductModel productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      floatingActionButton: _renderFloatingButton(context),
      body: _renderlist(),
    );
  }

  Widget _renderFloatingButton(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('product');
        },
      ),
    );
  }

  Widget _renderlist() {
    return FutureBuilder(
      future: productProvider.getAll(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int i) {
              return _createItem(context, products[i]);
            },
          );
        }
      },
    );
  }

  Widget _createItem(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            (product.photoUrl == null)
                ? Image(
                    height: 280,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/no-image.png'),
                  )
                : FadeInImage(
                    height: 280,
                    fit: BoxFit.contain,
                    image: NetworkImage(product.photoUrl),
                    placeholder: AssetImage('assets/images/jar-loading.gif'),
                  ),
            ListTile(
              title: Text(product.title),
              subtitle: Text('${product.price.toString()}\$'),
              onTap: () {
                Navigator.of(context).pushNamed('product', arguments: product);
              },
            )
          ],
        ),
      ),
      onDismissed: (dir) {
        productProvider.deleteOne(product.id);
      },
    );
  }
}
