import 'package:dashboard/View/History/histoque.dart';
import 'package:dashboard/View/Post/post.dart';
import 'package:dashboard/View/Scan/scan.dart';
import 'package:dashboard/View/User/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controller/controller.dart';
import 'View/User/dash_board_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Controller(),)
        ],
        child: DashBoardScreen(),
      ),
      routes: {
        '/dashboard': (context) => DashBoardScreen(),
        '/post': (context) => PostScreen(),
        '/scan': (context) => ScanScreen(),
        '/history': (context) => HistoriqueScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}




