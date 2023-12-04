

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../custom_appbar.dart';

class DashboardContent extends StatelessWidget{
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return SafeArea(
     child: SingleChildScrollView(
       padding: EdgeInsets.all(appPadding),
       child: Column(
          children: [
            CustomAppbar(),
            SizedBox(
              height: appPadding,
            ),
          ],
       ),
     ),
    );
  }

}