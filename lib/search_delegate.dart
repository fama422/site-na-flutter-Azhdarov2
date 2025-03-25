import 'package:flutter/material.dart';
import 'models.dart';
import 'supplier_detail_screen.dart';
import 'contractor_detail_screen.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Supplier> suppliers;
  final List<Contractor> contractors;

  CustomSearchDelegate({required this.suppliers, required this.contractors});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final supplierResults = suppliers
        .where((supplier) => supplier.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final contractorResults = contractors
        .where((contractor) => contractor.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (supplierResults.isEmpty && contractorResults.isEmpty) {
      return Center(
        child: Text(
          'Ничего не найдено',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return ListView(
      children: [
        if (supplierResults.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Поставщики:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ...supplierResults.map((supplier) => ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(supplier.imageUrl),
              ),
              title: Text(supplier.name),
              subtitle: Text(supplier.description),
              onTap: () {
                close(context, '');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupplierDetailScreen(supplier: supplier),
                  ),
                );
              },
            )),

        if (contractorResults.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Подрядчики:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ...contractorResults.map((contractor) => ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(contractor.imageUrl),
              ),
              title: Text(contractor.name),
              subtitle: Text(contractor.description),
              onTap: () {
                close(context, '');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContractorDetailScreen(contractor: contractor),
                  ),
                );
              },
            )),
      ],
    );
  }
}