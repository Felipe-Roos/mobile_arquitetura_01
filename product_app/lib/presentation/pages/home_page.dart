import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_app/presentation/pages/productpage.dart';
import 'package:product_app/presentation/pages/favorites_page.dart';
import 'package:product_app/presentation/viewmodels/productviewmodel.dart';
import 'package:product_app/provider/favorites_provider.dart';

class HomePage extends StatefulWidget {
  final ProductViewModel viewModel;

  const HomePage({
    super.key,
    required this.viewModel,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product App"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(
              icon: Icon(Icons.shopping_cart),
              text: "Produtos",
            ),
            Tab(
              icon: const Icon(Icons.favorite),
              text: "Favoritos (${context.watch<FavoritesProvider>().favorites.length})",
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: widget.viewModel.loadProducts,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductPage(viewModel: widget.viewModel),
          const FavoritesPage(),
        ],
      ),
    );
  }
}
