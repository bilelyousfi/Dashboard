import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/View/History/Historique.dart';
import 'package:dashboard/View/History/rapport_production_component.dart';
import 'package:dashboard/View/History/task_filter_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../components.dart';



class PendingTaskScreen extends StatefulWidget {
   PendingTaskScreen({super.key});

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {

  DateTime firstDate =DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  DateTime lastDate =DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  List<String> employe = [];
  List<String> product = [];
  String? selectedEmploye;
  String? selectedProduct;
  bool rapport = false;
  Map<String,double> rapportList ={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: getData(), // Use the function to get the stream
        builder: ( context,  snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data!.isEmpty ){
            return Column(
              children: [
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(context: context,

                      builder: (context) {
                        return TaskFilterComponent(
                          categorieList: employe,
                          onApplyFilter: handleFilter,
                          done: true,
                          firstdate: firstDate,
                          lastDate: lastDate,
                          category: selectedEmploye,
                          categorieList1: product,
                          category1: selectedProduct,


                        );
                      },);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: mainColor,
                        width: 2,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: mainColor, size: 35),
                          SizedBox(width: 5,),
                          Text('Rate ?',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                            ),),
                          Spacer(),
                          Icon(Icons.filter_list_rounded,
                              color: mainColor,
                              size: 35),
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text('Aucune donnée disponible',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 50
                    ),),
                ),
              ],
            );

          }

          return ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20,);
            },
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var document = snapshot.data![index];

              var date = (document['date']);


              bool showDateHeader = index == 0 || date.day != snapshot.data![index - 1]['date'].day;


              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(index == 0)
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(context: context,

                          builder: (context) {
                            return TaskFilterComponent(
                              categorieList1: product,
                              categorieList:employe,
                              category1: selectedProduct,
                              onApplyFilter: handleFilter,
                              done: true,
                              firstdate: firstDate,
                              lastDate: lastDate,
                              category: selectedEmploye,


                            );
                          },);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: mainColor,
                            width: 2,),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding:  EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: const [
                              Icon(Icons.search, color: mainColor, size: 35),
                              SizedBox(width: 5,),
                              Text('Rate ?',
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800
                                ),),
                              Spacer(),
                              Icon(Icons.filter_list_rounded,
                                  color: mainColor,
                                  size: 35),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if(index == 0)
                    RapportComponent(raport: rapport, rapportList: rapportList),
                  if (showDateHeader)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('d MMMM yyyy').format(date),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight
                            .bold),
                      ),
                    ),
                  HistoriqueItem2(

                      document: document,

                     ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> getDoneTaskStream() {
    return FirebaseFirestore.instance
        .collection('UserTask')
        .where('statusT', isEqualTo: false)
        .orderBy('date', descending: true)


        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getData() {
    // Replace 'collection1' and 'collection2' with your actual collection names
    CollectionReference collection = FirebaseFirestore.instance.collection('Rate');



    return collection.snapshots().asyncMap((QuerySnapshot snapshot1) async {
      List<Map<String, dynamic>> result = [];


      // for (QueryDocumentSnapshot doc1 in snapshot1.docs) {
      //
      //   String name = doc1['name'];
      //   String description = doc1['description'];
      //   String categorie = doc1['categorie'];
      //   String imageUrl = doc1['imageUrl'];
      //   categorieList.contains(categorie)?null:categorieList.add(categorie);


      // assuming 'name' is the field linking the collections
      QuerySnapshot snapshot;
      // Fetch data from the second collection using the name field
      if(selectedEmploye == null){
        if(selectedProduct == null){
          snapshot = await collection
              .orderBy('date',descending: true)
              .get();
        }
        else{
          snapshot = await collection
              .orderBy('date',descending: true)
              .where('ProductName', isEqualTo:selectedProduct)
              .get();
        }


      }
      else {

        if(selectedProduct == null ){
          snapshot = await collection
              .where('UserName', isEqualTo:selectedEmploye)
              .orderBy('date',descending: true)
              .get();
        }
        else{
          snapshot = await collection
              .where('UserName', isEqualTo:selectedEmploye)
              .where('ProductName', isEqualTo:selectedProduct)
              .orderBy('date',descending: true)
              .get();
        }

      }




      Map<String,int> rpl ={};
      Map<String, int> rapport = {};
      // Extract quantity and date
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        employe.contains(doc['UserName'])?null:employe.add(doc['UserName']);
        product.contains(doc['ProductName'])?null:product.add(doc['ProductName']);


        DateTime date = doc['date'].toDate();
        String f =DateFormat('yyyy-MM-dd').format(firstDate);
        String l =DateFormat('yyyy-MM-dd').format(lastDate);

        print(firstDate);
        print(lastDate);
        print(date);
        print('---------------------------------------------------------------$date------------------------------------');// Assuming 'date' is a Timestamp field
        DateTime t =DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
        String d =DateFormat('yyyy-MM-dd').format(t);
        if(f == d && l == d){
          Map<String, dynamic> combinedData = {
            'UserName': doc['UserName'],
            'ProductName': doc['ProductName'],
            'Rate': doc['Rate'],
            'date': date,



          };
          result.add(combinedData);
          if(rapport.containsKey(doc['ProductName'])){
            rapport[doc['ProductName']] = rapport[doc['ProductName']]! + doc['Rate'] as int;
            rpl[doc['ProductName']] = rpl[doc['ProductName']]! + 1;
          }
          else{
            rapport[doc['ProductName']] = doc['Rate'];
            rpl[doc['ProductName']] = 1;

          }
        }
        else{
          if((firstDate.isBefore(date) ||  (firstDate.year == date.year && firstDate.month == date. month && firstDate.day == date.day))
              && (lastDate.isAfter(date) ||(lastDate.year == date.year && lastDate.month == date. month && lastDate.day == date.day) )){
            Map<String, dynamic> combinedData = {
              'UserName': doc['UserName'],
              'ProductName': doc['ProductName'],
              'Rate': doc['Rate'],
              'date': date,



            };
            result.add(combinedData);
            if(rapport.containsKey(doc['ProductName'])){
              rapport[doc['ProductName']] = rapport[doc['ProductName']]! +  doc['Rate'] as int;
              rpl[doc['ProductName']] = rpl[doc['ProductName']]! + 1;
            }
            else{
              rapport[doc['ProductName']] = doc['Rate'];
              rpl[doc['ProductName']] = 1;
            }
          }
        }


        // Build a combined map

      }



      rapport.forEach((key, value) {
        if (rpl.containsKey(key) && rpl[key] != 0) {
          rapportList[key] = value / rpl[key]! as double;
        } else {
          rapportList[key] = value as double; // Handle division by zero or missing key
        }
      });
      //}
      print(result);

      return result;
    });
  }






  void handleFilter(DateTime firstDate, DateTime lastDate,
      String? selectedValue, String? selectedValue1) {
    setState(() {
      this.firstDate = firstDate;
      this.lastDate = lastDate;
      selectedEmploye = selectedValue;
      selectedProduct = selectedValue1;
    });
  }
}