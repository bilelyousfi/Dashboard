import 'package:dashboard/View/History/product.dart';

class History {

  // Attributs
  final String? id;
  final String userId;
  final Product productId;
  final DateTime date;


  // Constructor
  History({
    this.id,
    required this.userId,
    required this.productId,
    required this.date,
  });


  // Deserialization
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['_id'],
      userId: json['userId'],
      productId: Product.fromJson(json['productId']),
      date: DateTime.parse(json['date']),
    );
  }
    
}