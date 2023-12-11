import 'dart:convert';
import 'package:http/http.dart' as http;
import 'productModel.dart';

class ApiService {

  final String _baseUrl = "http://192.168.1.151:3000";

  // GET ALL PRODUCTS
  Future<List<ProductModel>> getAll() async {
    var url = Uri.parse('$_baseUrl/product');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body)["products"];
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }


  // ADD PRODUCT
  Future<void> addProduct(ProductModel product) async {
    var url = Uri.parse('$_baseUrl/product');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add product');
    }
  }


  // UPDATE PRODUCT
  Future<void> updateProduct(String productId, ProductModel product) async {
    var url = Uri.parse('$_baseUrl/product/$productId');
    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }


  // DELETE PRODUCT
  Future<void> deleteProduct(String productId) async {
    var url = Uri.parse('$_baseUrl/product/$productId');
    var response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }


}