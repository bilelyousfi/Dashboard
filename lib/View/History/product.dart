class Product {

  // Attributs
  final String? id;
  final String name;
  final String description;
  final String image;
  final String code;
  final double  carbonFootPrint;
  final double  waterConsumption;
  final double  recyclability;
  final String category;
  final String brand;
  final double  price;
  final int stock;
  final int sales;


  // Constructor
  Product({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.code,
    required this.carbonFootPrint,
    required this.waterConsumption,
    required this.recyclability,
    required this.category,
    required this.brand,
    required this.price,
    required this.stock,
    required this.sales,
  });


  // Deserialization
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      code: json['code'],
      carbonFootPrint: json['carbonFootPrint'].toDouble(),
      waterConsumption: json['waterConsumption'].toDouble(),
      recyclability: json['recyclability'].toDouble(),
      category: json['category'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      sales: json['sales'],
    );
  }


  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'code': code,
      'carbonFootPrint': carbonFootPrint,
      'waterConsumption': waterConsumption,
      'recyclability': recyclability,
      'category': category,
      'brand': brand,
      'price': price,
      'stock': stock,
      'sales': sales,
    };
  }
  
    
}