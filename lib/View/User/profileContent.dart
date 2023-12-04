





import 'package:dashboard/View/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ProfileContents extends StatelessWidget {
  const ProfileContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [
            CustomAppbar(),
            SizedBox(height: appPadding),
            CircleAvatar(
              radius: 50, // Taille de l'image
              backgroundImage: NetworkImage('assets/images/photo3.jpg'), // Changez cela pour votre image
            ),
            SizedBox(height: appPadding),
            Container(
              padding: EdgeInsets.symmetric(horizontal: appPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
              ),
            ),
            SizedBox(height: appPadding / 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: appPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',

                  ),
                ),
              ),
            ),
            SizedBox(height: appPadding / 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: appPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone',

                  ),
                ),
              ),
            ),
            SizedBox(height: appPadding),
            ElevatedButton(
              onPressed: () {
                // Logique de mise à jour
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Couleur du bouton
              ),
            ),
          ],
        ),
      ),
    );
  }
}