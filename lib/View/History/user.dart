class User {

  // Attributs
  final String? id;  // Rendre l'ID facultatif
  final String name;
  final String email;
  final String phone;


  // Constructor
  User({
    this.id,  // Rendre l'ID facultatif
    required this.name,
    required this.email,
    required this.phone,
  });


  // Deserialization
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }


  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
  
    
}