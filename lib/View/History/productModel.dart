class ProductModel {

  // Attributs
  final String name;
  final String description;
  final String code;
  final String carbonFootPrint;
  final String waterConsumption;
  final String recyclability;
  
  // Constructor
  ProductModel({
    required this.name,
    required this.description,
    required this.code,
    required this.carbonFootPrint,
    required this.waterConsumption,
    required this.recyclability,
  });

  // Deserialization
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      description: json['description'],
      code: json['code'],
      carbonFootPrint: json['carbonFootPrint'],
      waterConsumption: json['waterConsumption'],
      recyclability: json['recyclability'],
    );
  }


  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'code': code,
      'carbonFootPrint': carbonFootPrint,
      'waterConsumption': waterConsumption,
      'recyclability': recyclability,
    };
  }
  
    
}