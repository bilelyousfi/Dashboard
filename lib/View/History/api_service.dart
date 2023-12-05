import 'dart:convert';
import 'package:http/http.dart' as http;
import 'productModel.dart';

class ApiService {

  final String _baseUrl = "http://172.20.10.3:9090";


//   Future<List<ProductModel>> getAll() async {
//   var url = Uri.parse('$_baseUrl/product');
//   var response = await http.get(url);
//   List<ProductModel> models = [];
//   if (response.statusCode == 200) {
//     List<dynamic> responseBody = json.decode(response.body)["Products"];
//     for (var item in responseBody) {
//       models.add(ProductModel.fromJson(item));
//     }
//   } else {
//     throw Exception('Failed to load products');
//   }
//   return models;
// }

Future<List<ProductModel>> getAll() async {
    var url = Uri.parse('$_baseUrl/product');
    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body)["Products"];
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

}