

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    var url = Uri.parse('http://localhost:3000/user/loginAdmin');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {

        return {'success': true, 'data': json.decode(response.body)};
      } else {

        return {'success': false, 'message': json.decode(response.body)['message']};
      }
    } catch (error) {

      return {'success': false, 'message': error.toString()};
    }
  }
}
