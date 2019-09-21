import 'dart:convert';
import 'dart:io';

import 'package:forms_validations/src/models/product.model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

class ProductsProvider {
  final baseUrl = 'https://flutter-shop-ebb1c.firebaseio.com/';
  final cloudinaryUrl = Uri.parse('https://api.cloudinary.com/v1_1/di3vwjpzq/image/upload?upload_preset=ehne3fhx');
  Future<List<ProductModel>> getAll() async {
    final url = '$baseUrl/products.json';
    final result = await http.get(url);
    final Map<String, dynamic> decoded = json.decode(result.body);
    print('decoded data $decoded');
    final List<ProductModel> products = new List();
    if (decoded == null) return [];

    decoded.forEach((id, el) {
      final temp = ProductModel.fromJson(el);
      temp.id = id;

      products.add(temp);
    });

    return products;
  }

  Future<bool> add(ProductModel product) async {
    final url = '$baseUrl/products.json';
    final result = await http.post(url, body: productModelToJson(product));
    final decoded = json.decode(result.body);

    return true;
  }

  Future<bool> edit(ProductModel product) async {
    final id = product.id;

    final url = '$baseUrl/products/$id.json';
    final result = await http.put(url, body: productModelToJson(product));
    final decoded = json.decode(result.body);
      print('decoded data $decoded');
    return true;
  }

  Future<int> deleteOne(String id) async {
    final url = '$baseUrl/products/$id.json';
    final result = await http.delete(url);
    return 1;
  }

  Future<String> upload(File image)async{
/*     https://api.cloudinary.com/v1_1/di3vwjpzq/image/upload?upload_preset=ehne3fhx
 */
    final mimeType = mime(image.path).split('/');

    final  request= http.MultipartRequest(
      'post',
      cloudinaryUrl
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(
        mimeType[0],
        mimeType[1]
        )
    );

    request.files.add(file);

    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
    if(response.statusCode != 200 && response.statusCode != 201){
      print('error ${response.body}');
      return null;
    }
    final decoded = json.decode(response.body);

    return decoded['secure_url'];
  }
}
