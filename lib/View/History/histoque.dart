import 'package:dashboard/View/History/history.dart';
import 'package:dashboard/View/History/api_service.dart'; // Assurez-vous d'importer correctement votre service
import 'package:flutter/material.dart';

class HistoriqueScreen extends StatefulWidget {
  @override
  _HistoriqueScreenState createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  final ApiService _apiService = ApiService();
  int _currentPage = 1;
  int _limit = 10;
  List<History> _histories = [];
  int _totalHistories = 0;

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  Future<void> _loadHistoryData() async {
    try {
      final result = await _apiService.getAllHistory(_currentPage, _limit);

      setState(() {
        _histories = result['histories'];
        _totalHistories = result['totalHistories'];
      });
    } catch (e) {
      print('Error loading history data: $e');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product History Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOverviewSection(),
          ],
        ),
      ),
    );
  }


  Widget _buildOverviewSection() {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Vue d\'ensemble des historiques',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40.0,
            ),

      // ************************  Search Product && filter section ****************************
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Search Product With name, brand, category
                        Container(
                          width: 300.0,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type Product Name",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                          // Affichage du totalHistories
                          Text('Total Histories: $_totalHistories'),                          
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

      // **************************  Product Table ***************
            DataTable(
              headingRowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.grey.shade200,
              ),
              columns: [
                DataColumn(label: Text("Product Name")),
                DataColumn(label: Text("Description")),
                DataColumn(label: Text("Code")),
                DataColumn(label: Text("Category")),
                DataColumn(label: Text("Brand")),
                DataColumn(label: Text("Price")),
                DataColumn(label: Text("Stock")),
                DataColumn(label: Text('Date')),
              ],
              rows: _histories.map((history) {
                return DataRow(cells: [
                  DataCell(Text(history.productId.name)),
                  DataCell(Text(history.productId.description)),
                  DataCell(Text(history.productId.code)),
                  DataCell(Text(history.productId.category)),
                  DataCell(Text(history.productId.brand)),
                  DataCell(Text(history.productId.price.toString())),
                  DataCell(Text(history.productId.stock.toString())),
                  DataCell(Text(history.date.toString())),
                ]);
              }).toList(),
            ),

            
          SizedBox(height: 16.0),
          

            // Pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _currentPage > 1 ? () => _loadPreviousPage() : null,
                  child: Text('Previous Page'),
                ),
                SizedBox(width: 16.0),
                Text('Page $_currentPage of ${(_totalHistories / _limit).ceil()}'),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _currentPage < (_totalHistories / _limit).ceil() ? () => _loadNextPage() : null,
                  child: Text('Next Page'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
  void _loadPreviousPage() {
    setState(() {
      _currentPage--;
    });
    _loadHistoryData();
  }

  void _loadNextPage() {
    setState(() {
      _currentPage++;
    });
    _loadHistoryData();
  }
}
