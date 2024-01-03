
class Post {
  //att
  final String id;
  final String content;
  final String  publicationDate;
  //final List<String> likes;
  final String iduser;
  final String media;
  final int signaler;
  final int bloquer;

  //constuctor
  Post(this.id,this.content,this.publicationDate,this.iduser,this.media,this.signaler,this.bloquer);

  //Post(this.id, this.content, this.publicationDate, this.likes, this.iduser,this.media);
 Map<String,dynamic> toJson(){
    return{
      "id":id,
      "content":content,
      "publicationDate":publicationDate,
      "iduser":iduser,
      "media":media,
      "signaler":signaler,
      "bloquer":bloquer
    };
 }

 static fromJson(Map<String,dynamic> jsonData){
   return Post(jsonData['id'],jsonData['content'],jsonData['publicationDate'],jsonData['iduser'],jsonData['media'],jsonData['signaler'],jsonData['bloquer']);
 }

}
