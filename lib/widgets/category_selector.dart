import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.grey),
          child: Text(
            'Categories',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          title: const Text('Men All'),
          selected: selectedCategory == 'men_all',
          onTap: () => onCategoryChanged('men_all'),
        ),
        ListTile(
          title: const Text('Ladies New Arrivals'),
          selected: selectedCategory == 'ladies_newarrivals_all',
          onTap: () => onCategoryChanged('ladies_newarrivals_all'),
        ),
      ],
    );
  }
}
