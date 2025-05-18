import 'package:flutter/material.dart';
import 'package:rattrap/contant/categories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            // random color icon
            leading: Icon(
              Icons.category,
              color: Colors.primaries[index % Colors.primaries.length],
            ),
            onTap: () {
              // Handle category selection
            },
          );
        },
      ),
    );
  }
}
