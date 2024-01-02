import 'dart:io';





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../components.dart';
import '../../constants/responsive.dart';
import '../drawer_menu.dart';
import 'Categorie.dart';



class AddCategorieProductionScreen extends StatefulWidget {
  const AddCategorieProductionScreen({Key? key, this.type, this.document}) : super(key: key);
  final String? type;
  final String? document;


  @override
  State<AddCategorieProductionScreen> createState() => _AddCategorieProductionScreenState();
}

class _AddCategorieProductionScreenState extends State<AddCategorieProductionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ProductController = TextEditingController();
  TextEditingController Commentaire = TextEditingController();


  CategorieProduction _categorie = CategorieProduction();
  var formKey = GlobalKey<FormState>();

  List<String> colors = ['Verte','Bleu','Violet','Orange','Rose','Grise'];
  String? selectedValue ;
  bool imageError = false;
  bool loading = false;

  void initState() {
    super.initState();
    if (widget.type == 'update') {
      _categorie.getDocumentById(widget.document).then((document) {
        if (document != null) {
          nameController.text = document.data()!['UserName'];
          ProductController.text = document.data()!['ProductName'];
          Commentaire.text = document.data()!['Commentaire'];




         
          print('Document data: ${document.data()}');
        } else {
          // Document doesn't exist
          print('Document not found.');
        }
      });



    }
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerMenu(),
      body: Row(
        children: [
          if (Responsive.isDesktop(context))
            Expanded(child: DrawerMenu(),),
          Expanded(
            flex: 5,
            child: Form(
              key:  formKey ,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      color: mainColor,
                      child: Center(
                        child: Text('${widget.type == 'update' ? 'Modifier Category' : 'Ajouter Category' }',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                          ),
                        ),
                      ),),
                    Padding(
                      padding: const EdgeInsets.only(left: 150,right: 150),
                      child: Column(
                        children: [





                          SizedBox(height: 20),
                          defaultFormField(
                              contoller: nameController,
                              type: TextInputType.text,
                              validate: (value){
                                if(value.isEmpty){
                                  return'le nom est manquant ';
                                }
                              },
                              label: 'UserName',
                              prefix: Icons.person
                          ),
                          SizedBox(height: 20),
                          defaultFormField(
                              contoller: ProductController,
                              type: TextInputType.text,
                              validate: (value){
                                if(value.isEmpty){
                                  return'le nom est manquant ';
                                }
                              },
                              label: 'Product Name',
                              prefix: Icons.propane_tank_rounded
                          ),
                          SizedBox(height: 20),
                          defaultFormField(
                              contoller: Commentaire,
                              type: TextInputType.text,
                              validate: (value){
                                if(value.isEmpty){
                                  return'le nom est manquant ';
                                }
                              },
                              label: 'Commentaire',
                              prefix: Icons.comment
                          ),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [


                              SizedBox(width:10 ,),
                              AddButton(
                                  color: greenColor,
                                  pressed: () async {
                                    if(!loading){
                                      if( widget.type != 'update'){
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;

                                            imageError = false;
                                          });
                                          await _categorie.SetData(
                                              nameController.text,
                                              ProductController.text,
                                              Commentaire.text
                                          );
                                          Navigator.pop(context);

                                        }
                                        else{

                                        }



                                      }
                                      else{
                                        if (formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Modification'),
                                              content: Text('Êtes-vous sûr de vouloir modifier ce employé ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                  child: Text('Non'),
                                                ),
                                                TextButton(
                                                  onPressed: loading ? null :() async {
                                                    setState(() {
                                                      loading =true;
                                                    });


                                                    await _categorie.update(widget.document,
                                                      nameController.text ,
                                                      nameController.text,
                                                      nameController.text



                                                    );
                                                    Navigator.of(context).pop(true);
                                                  },
                                                  child:Text('Oui'),
                                                ),
                                              ],
                                            ),
                                          ).then((value) {
                                            // If the user confirmed, close the app
                                            if (value == true) {
                                              Navigator.pop(context);
                                            }
                                          });
                                        }

                                      }
                                    }
                                    else
                                      null;







                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (ctx) => const ShowProviderScreen()));
                                  }, text: '${widget.type =='update' ? 'Modifier': 'Créer' }',
                              loading: loading),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }















}
