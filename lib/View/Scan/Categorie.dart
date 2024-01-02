import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';



class CategorieProduction{






  SetData(String productName,String userName, int rate) async {
    DateTime date = DateTime.now();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Rate");
       await usersCollection.add({
        "ProductName": productName,
        "UserName":userName,
        "Rate": rate,
         "date": date

      });

  }


  Stream<QuerySnapshot> getCategorieStream()  {
    return  FirebaseFirestore.instance
        .collection('Rate')
        .snapshots();


  }











//////////////////////////



  Delete(String? document) async {

    final collection = FirebaseFirestore.instance.collection('Rate');

    await collection
        .doc(document) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) async {


        print('Documents deleted successfully');



    }).catchError((error) {

      print('Delete failed: $error');
    } );

  }

  // Update(String name,String description,String time) {
  //   print('tttttttttttttttttttttttttttttttttttttttttttssssss');
  //   var collection = FirebaseFirestore.instance.collection('TaskData');
  //    collection.doc().update({"name":'aaa'});
  // }
  Future<void> update(String? document ,String productName,String userName,int rate) async {




    var collection = FirebaseFirestore.instance.collection('Rate');

      await collection.doc(document).update({
        "ProductName": productName,
        "UserName":userName,
        "rate": rate,

      }).then((value) {
        print ("updated");
      }).catchError((error){
        print(error);

      });
    }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getDocumentById(String? documentId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore.instance.collection('Rate').doc(documentId).get();
      if (document.exists) {
        // Document found
        return document;
      } else {
        // Document doesn't exist
        return null;
      }
    } catch (e) {
      print('Error getting document by ID: $e');
      return null;
    }
  }






}