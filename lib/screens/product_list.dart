import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  List<Product> products = [];
  bool isLoading = false;
  int currentPage = 0;
  String selectedCategory = 'men_all';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final newProducts = await _apiService.getProducts(currentPage, selectedCategory);
      setState(() {
        products = newProducts;
        isLoading = false;
      });

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'H&M Products',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : AnimationLimiter(
              child: GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: ProductCard(product: products[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          _buildPaginationControls(),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Center(
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Men'),
            selected: selectedCategory == 'men_all',
            onTap: () {
              setState(() {
                selectedCategory = 'men_all';
                currentPage = 0;
              });
              Navigator.pop(context);
              _fetchProducts();
            },
          ),
          ListTile(
            title: const Text('Ladies New Arrivals'),
            selected: selectedCategory == 'ladies_newarrivals_all',
            onTap: () {
              setState(() {
                selectedCategory = 'ladies_newarrivals_all';
                currentPage = 0;
              });
              Navigator.pop(context);
              _fetchProducts();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage > 0)
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                setState(() => currentPage--);
                _fetchProducts();
              },
              child: const Text('Previous'),
            ),
          const SizedBox(width: 16),
          Text('Page ${currentPage + 1}'),
          const SizedBox(width: 16),
          if (products.length == 30)
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                setState(() => currentPage++);
                _fetchProducts();
              },
              child: const Text('Next'),
            ),
        ],
      ),
    );
  }
}
