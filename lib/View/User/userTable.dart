

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/User.dart';

class UserTable extends StatelessWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = [
      UserData('Deniz Çolak', 'de****@huawei.com', '1234567890'),
      UserData('Deniz Çolak', 'de****@huawei.com', '1234567890'),
      UserData('Deniz Çolak', 'de****@huawei.com', '1234567890'),
      UserData('Deniz Çolak', 'de****@huawei.com', '1234567890'),
      UserData('Deniz Çolak', 'de****@huawei.com', '1234567890'),
      UserData('Deniz Çolak', 'de****@huawei.com', '1234567890'),
      UserData('Deniz Çolak', 'de****@huawei.com', '1234567890'),

      // Ajouter plus d'utilisateurs ici...
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0), // Ajustez le padding selon vos besoins
          child: Text(
            'List of Users',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,


            ),
          ),
        ),
        Container(
          color: Color(0xFF31304D),
         child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Username',style: TextStyle(color: Colors.white),)),
                DataColumn(label: Text('E-mail',style: TextStyle(color: Colors.white),)),
                DataColumn(label: Text('Phone',style: TextStyle(color: Colors.white),)),
                DataColumn(label: Text('Actions',style: TextStyle(color: Colors.white),)),
              ],
              rows: users.map((user) => DataRow(cells: [
                DataCell(Text(user.Username,style: TextStyle(color: Colors.white),)),
                DataCell(Text(user.email,style: TextStyle(color: Colors.white),)),
                DataCell(Text(user.phone,style: TextStyle(color: Colors.white),)),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.block, color: Colors.red),
                      onPressed: () {
                        // Logique pour bannir l'utilisateur
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () {
                        // Logique pour débannir l'utilisateur
                      },
                    ),
                  ],
                )),
              ])).toList(),
            ),
          ),
        )

      ],
    );
  }
}