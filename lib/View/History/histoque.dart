import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../drawer_menu.dart';
import 'package:dashboard/View/History/api_service.dart';
import 'package:dashboard/View/History/productModel.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({Key? key}) : super(key: key);

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreen();
}

class _HistoriqueScreen extends State<HistoriqueScreen> {

  final ApiService _apiService = ApiService();

  // pour le formulaire
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _carbonFootPrintController = TextEditingController();
  final TextEditingController _waterConsumptionController = TextEditingController();
  final TextEditingController _recyclabilityController = TextEditingController();
  // variable d'etat pour stocker la liste des produits dans votre classe d'etat
  List<ProductModel> _products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),

              // Dashboard Main Rapports
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDashboardCard(Icons.article, "Total Products", "6 Products"),
                  _buildDashboardCard(Icons.article, "Total Purchases", "+32 Purchases", color: Colors.red),
                  _buildDashboardCard(Icons.people, "Clients", "3.2M Clients", color: Colors.amber),
                  _buildDashboardCard(Icons.monetization_on_outlined, "Revenue", "2.300 DT", color: Colors.green),
                ],
              ),

              SizedBox(height: 50.0),

              // Search Product With Name && Filter Section
              _buildSearchAndFilter(),

              SizedBox(height: 40.0),

              // Products Table
              _buildProductsTable(),
            ],
          ),
        ),
      ),

      // Floating Action Button to Add a Product
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: purple,
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String value, {Color? color}) {
    return Expanded(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 26.0,
                    color: color,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 300.0,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Type Product Name",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
              ),
            ),
          ),
        ),
        Row(
          children: [
            DropdownButton(
              hint: Text("Filter by"),
              items: [
                DropdownMenuItem(value: "Date", child: Text("Date")),
                DropdownMenuItem(value: "name", child: Text("Name")),
                DropdownMenuItem(value: "code", child: Text("Code")),
              ],
              onChanged: (value) {},
            ),
            SizedBox(width: 20.0),
            DropdownButton(
              hint: Text("Order by"),
              items: [
                DropdownMenuItem(value: "date", child: Text("Date")),
                DropdownMenuItem(value: "name", child: Text("Name")),
                DropdownMenuItem(value: "code", child: Text("Code")),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductsTable() {
    return FutureBuilder<List<ProductModel>>(
      future: _apiService.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else {
          // Mettez à jour votre FutureBuilder pour utiliser la liste des produits stockée dans l'état local 
          _products = snapshot.data!;
          //List<ProductModel> products = snapshot.data!;

          return DataTable(
            headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),
            dataRowHeight: 80.0,
            columns: [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Product Name")),
              DataColumn(label: Text("Description")),
              DataColumn(label: Text("Code")),
              DataColumn(label: Text("CarbonFootPrint")),
              DataColumn(label: Text("Water Consumption")),
              DataColumn(label: Text("Recyclability")),
              DataColumn(label: Text("Actions")),
            ],
            //rows: products.map((product) {
            rows: _products.map((product) {
              return DataRow(
                cells: [
                  DataCell(Text(product.id!)),
                  DataCell(Text(product.name)),
                  DataCell(Text(product.description)),
                  DataCell(Text(product.code)),
                  DataCell(Text(product.carbonFootPrint)),
                  DataCell(Text(product.waterConsumption)),
                  DataCell(Text(product.recyclability)),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.yellow),
                          onPressed: () {
                            // Action when Edit button is pressed
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Action when Delete button is pressed
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        }
      },
    );
  }

void _showAddProductDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Product'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  // Validation logique pour la description
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(labelText: 'Code'),
                validator: (value) {
                  // Validation logique pour le code
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carbonFootPrintController,
                decoration: InputDecoration(labelText: 'Carbon FootPrint'),
                validator: (value) {
                  // Validation logique pour l'empreinte carbone
                  if (value == null || value.isEmpty) {
                    return 'Please enter Carbon FootPrint';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _waterConsumptionController,
                decoration: InputDecoration(labelText: 'Water Consumption'),
                validator: (value) {
                  // Validation logique pour la consommation d'eau
                  if (value == null || value.isEmpty) {
                    return 'Please enter Water Consumption';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _recyclabilityController,
                decoration: InputDecoration(labelText: 'Recyclability'),
                validator: (value) {
                  // Validation logique pour la recyclabilité
                  if (value == null || value.isEmpty) {
                    return 'Please enter Recyclability';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await _apiService.addProduct(
                    ProductModel(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      code: _codeController.text,
                      carbonFootPrint: _carbonFootPrintController.text,
                      waterConsumption: _waterConsumptionController.text,
                      recyclability: _recyclabilityController.text,
                    ),
                  );

                  // Mise à jour de l'état local ici
                  setState(() {
                    // Vous pouvez mettre à jour d'autres états si nécessaire
                  });

                  // Réinitialiser les contrôleurs
                  _nameController.clear();
                  _descriptionController.clear();
                  _codeController.clear();
                  _carbonFootPrintController.clear();
                  _waterConsumptionController.clear();
                  _recyclabilityController.clear();

                  Navigator.pop(context);
                } catch (e) {
                  print('Error adding product: $e');
                }
              }
            },
            child: Text('Add'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}


}
