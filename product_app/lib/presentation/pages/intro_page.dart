import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:product_app/data/models/datasourches/product_remote_datasource.dart';
import 'package:product_app/data/models/datasourches/productcachedatasource.dart';
import 'package:product_app/repositories/productrepositoryimpl.dart';
import 'package:product_app/presentation/viewmodels/productviewmodel.dart';
import 'package:product_app/presentation/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade400,
              Colors.deepPurple.shade900,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              const Text(
                'Product App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Descubra os melhores produtos',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () {
                  final remote = ProductRemoteDatasource(Dio());
                  final cache = ProductCacheDatasource();
                  final repository = ProductRepositoryImpl(remote, cache);
                  final viewModel = ProductViewModel(repository);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(viewModel: viewModel),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Começar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
