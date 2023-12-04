

import 'package:dashboard/View/User/analytic_cards.dart';
import 'package:dashboard/View/User/userTable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/responsive.dart';
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
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          AnalyticCards(),
                          SizedBox(
                            height: appPadding,
                          ),
                          UserTable(),
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),
                        ],
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ],
       ),
     ),
    );
  }

}