import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/argument/post_argument.dart';
import 'package:http/http.dart' as http;

import 'package:dashboard/service/email_sender.dart';
class DetailsScreen extends StatefulWidget {
  //var
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  //var
  final EmailSender emailSender = EmailSender('hassen.mrakbenjebahi@esprit.tn','aeydtsxcwyjidmad');

  //actions
  Future<bool> bloquer(String post_id) async {
    //var
    bool isblocked = false;

    //url
    Uri verifyUri =
        Uri.parse("http://localhost:9090/posts/bloquer/$post_id");

    //headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    //request
    await http.put(verifyUri, headers: headers).then((response) {
      if (response.statusCode == 200) {
        emailSender.sendEmail(
            'hassendjerba98@gmail.com',
            'block post',
            'post blocked',
          );
        isblocked=true;
        
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Information"),
              content: const Text("Verify : Server error! Try again later"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            );
          },
        );
      }
    });

    return isblocked;
  }

Future<bool> debloquer(String post_id) async {
    //var
    bool isblocked = false;

    //url
    Uri verifyUri =
        Uri.parse("http://localhost:9090/posts/debloquer/$post_id");

    //headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    //request
    await http.put(verifyUri, headers: headers).then((response) {
      if (response.statusCode == 200) {
         emailSender.sendEmail(
            'hassendjerba98@gmail.com',
            'unblock post',
            'post unblocked',
          );
        isblocked=true;
        
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Information"),
              content: const Text("Verify : Server error! Try again later"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Dismiss"))
              ],
            );
          },
        );
      }
    });

    return isblocked;
  }
  //build
 @override
  Widget build(BuildContext context) {
     final PostArgument args =
        ModalRoute.of(context)?.settings.arguments as PostArgument;
    return Card(
      //margin: EdgeInsets.all(16.0),
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
      child: Column(
       // crossAxisAlignment: CrossAxisAlignment.stretch,
       mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            args.post.media,
            height: 200, // Adjust the height as needed
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              args.post.content,
              style: TextStyle(fontSize: 18),
            ),
          ),
          
           Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
             "Date:"+ args.post.publicationDate,
              
              style: TextStyle(fontSize: 12),
            ),
          ),
          
           SizedBox(height: 16), // Add space between text and button
            ElevatedButton(
            onPressed: () {
              // Ajoutez votre logique de clic sur le bouton ici
              if(args.post.bloquer == 0){
                  bloquer(args.post.id)
                      .then((isblock) {
                    if (isblock) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Information"),
                            content:
                                const Text("Post blocked successfully!"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pushReplacementNamed('/post'),
                                  child: const Text("OK"))
                            ],
                          );
                        },
                      );
                    } 
                  });

              }else{
                 debloquer(args.post.id)
                    .then((isunblock) {
                    if (isunblock) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Information"),
                            content:
                                const Text("Post unblocked successfully!"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pushReplacementNamed('/post'),
                                  child: const Text("OK"))
                            ],
                          );
                        },
                      );
                    } 
                  });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: args.post.bloquer == 0 ? Colors.red : Colors.green,
            ),
            child: Text(args.post.bloquer == 0 ? 'Block' : 'unblock'),
          ),
        ],
      ),
     ),
    );
  }
}
