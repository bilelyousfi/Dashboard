import 'dart:convert';
import 'package:http/http.dart' as http;
import 'productModel.dart';

class ApiService {

  final String _baseUrl = "http://192.168.1.151:9090";

  Future<List<ProductModel>> getAllProducts() async {
    var url = Uri.parse('$_baseUrl/product');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body);
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

}