import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../drawer_menu.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenu(),
      // key: context.read<Controller>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children :[
            if (Responsive.isDesktop(context))
              Expanded(child: DrawerMenu(),),
            Expanded(
              flex: 5,
              child: Center(
                child: Text('Hello Post', style: TextStyle(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}