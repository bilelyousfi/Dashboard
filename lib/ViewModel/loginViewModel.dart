// login_view_model.dart

import 'dart:js';

import 'package:flutter/material.dart';
import '../Service/authService.dart';
import '../View/User/dash_board_screen.dart';


class LoginViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();


  Future<void> login(String email, String password, BuildContext context) async {
    // Set isLoading to true when login begins
    notifyListeners();
    final result = await _authService.login(email, password);

    if (result['success']) {
      // Connexion réussie

      // Ici vous pouvez sauvegarder le token et naviguer vers l'écran d'accueil
      print('Token: ${result['data']['token']}');
      navigateToHome(context);
     // Set isLoading to false when login is complete

    } else {
      // Échec de la connexion, gérer l'erreur
      print('Error: ${result['message']}');
    }

  }

}

void navigateToHome(BuildContext context) {
  Navigator.of(context).pushReplacementNamed('/dashboard'); // Utilisez le nom de la route que vous avez défini
  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoardScreen()));
}
