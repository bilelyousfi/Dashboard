import 'dart:convert';
import 'package:http/http.dart' as http;
import 'productModel.dart';
import 'product.dart';
import 'history.dart';

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


// services pour le développement dashboard admin concernant les produits enregistrés dans les historiques

// Future<Map<String, dynamic>> getAllHistory(String searchQuery, String sortField, int page, int limit) async {
//     final response = await http.get(
//       Uri.parse('$_baseUrl/historique/all?searchQuery=$searchQuery&sortField=$sortField&page=$page&limit=$limit'),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final List<dynamic> historyList = data['histories'];
//       final int totalHistories = data['totalHistories'];

//       return {
//         'histories': historyList.map((json) => History.fromJson(json)).toList(),
//         'totalHistories': totalHistories,
//       };
//     } else {
//       throw Exception('Failed to load history');
//     }
//   }
// Get all History and pagination
Future<Map<String, dynamic>> getAllHistory(int page, int limit) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/historique/all?page=$page&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> historyList = data['histories'];
      final int totalHistories = data['totalHistories'];
      return {
        'histories': historyList.map((json) => History.fromJson(json)).toList(),
        'totalHistories': totalHistories,
      };
    } else {
      throw Exception('Failed to load history');
    }
}

  // Search History
  Future<List<History>> searchHistory(String productId, String date) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/historique/search?productId=$productId&date=$date'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> historyList = data['searcHistories'];
      return historyList.map((json) => History.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search history');
    }
  }

  // Sort History
  Future<List<History>> sortHistory(String field) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/historique/sort/$field'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> historyList = data['sortHistories'];
      return historyList.map((json) => History.fromJson(json)).toList();
    } else {
      throw Exception('Failed to sort history');
    }
  }



  // Get history statistics
  Future<Map<String, dynamic>> getHistoryStats() async {

    final response = await http.get(Uri.parse('$_baseUrl/historique/stats'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load history statistics');
    }
  }

  // Get history analysis
  Future<Map<String, dynamic>> getHistoryAnalysis(String type) async {

    final response = await http.get(Uri.parse('$_baseUrl/historique/analysis/$type'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load history analysis');
    }
  }


}