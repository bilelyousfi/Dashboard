import 'dart:convert';
import 'package:dashboard/service/post_service.dart';
import 'package:flutter/material.dart';
import 'Cell.dart';
import 'package:dashboard/model/post.dart';
import 'package:dashboard/util/ipconfig.dart';
import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../drawer_menu.dart';
import 'package:http/http.dart' as http; // Ajouter le package http

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});
 /*
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: bgColor,
      drawer: DrawerMenu(),
    body: FutureBuilder(
      future: Postservice().getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
             shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Cell(snapshot.data![index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
  );
}
*/
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: bgColor,
    drawer: DrawerMenu(),
    body: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              child: DrawerMenu(),
            ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Post Management Dashboard',
                      style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  // Example: GridView of posts
                  FutureBuilder(
                    future: Postservice().getAll(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Cell(snapshot.data![index]);
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



}





