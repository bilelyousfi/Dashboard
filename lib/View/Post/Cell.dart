import 'package:flutter/material.dart';
import 'package:dashboard/model/post.dart';
import 'details_screen.dart';
import 'package:dashboard/argument/post_argument.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Cell extends StatelessWidget {
  //var
  final Post mPost;
  const Cell(this.mPost, {super.key});
@override
  Widget build(BuildContext context) {
  Color statusColor = mPost.bloquer == 0 ?  Colors.green:Colors.red;
  String statusText = mPost.bloquer == 0 ? "Not blocked" : "Blocked";

     return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/Details',
        arguments: PostArgument(mPost));
      },
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: mPost.media,
            fit: BoxFit.cover,
            height: 200.0, // Ajustez la hauteur de l'image selon vos besoins
          ),
          ListTile(
            title: Text(mPost.content),
          ),
        Container(
          color: statusColor,
         // padding: EdgeInsets.all(8.0),
          child: Text(
            statusText,
            style: TextStyle(fontSize: 10,  color: Colors.white),
          ),
        ),
        ],
      ),
    );
  }

  
  
}
