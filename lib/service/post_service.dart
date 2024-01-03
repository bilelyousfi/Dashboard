import 'dart:convert';

import 'package:dashboard/model/post.dart';
import 'package:dashboard/util/ipconfig.dart';
import 'package:http/http.dart' as http;
class Postservice{
  Future <List<Post>> getAll() async{
    List<Post> posts = [];
    Uri url = Uri.parse("$BASE_URL/posts/postsignaler");
    var headers = {
      "Content-Type":"application/json"
    };
    await http.get(url,headers: headers).then((response) {
      if(response.statusCode == 200){
         List<dynamic> jsonPosts= json.decode(response.body);
         for(var item in jsonPosts){
           posts.add(Post.fromJson(item));
         }
      }
    }).onError((error, stackTrace) {
      print(error);
    });

     return posts;
  }
}