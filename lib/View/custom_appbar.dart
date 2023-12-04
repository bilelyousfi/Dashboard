import 'package:dashboard/View/profile_info.dart';
import 'package:dashboard/View/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/controller.dart';
import '../constants/constants.dart';
import '../constants/responsive.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context, listen: false);

    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          Consumer<Controller>(
            builder: (context, controller, child) {
              return IconButton(
                onPressed: controller.controlMenu,
                icon: Icon(Icons.menu, color: textColor.withOpacity(0.5)),
              );
            },
          ),
        Expanded(child: SearchField()),
        ProfileInfo(),
      ],
    );
  }
}
