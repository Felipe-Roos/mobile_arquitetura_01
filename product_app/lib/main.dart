import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:product_app/data/models/datasourches/product_remote_datasource.dart';
import 'package:product_app/data/models/datasourches/productcachedatasource.dart';
import 'package:product_app/repositories/productrepositoryimpl.dart';
import 'package:product_app/presentation/viewmodels/productviewmodel.dart'; // adiciona essa linha
import 'package:product_app/presentation/pages/productpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remote = ProductRemoteDatasource(Dio());
    final cache = ProductCacheDatasource();
    final repository = ProductRepositoryImpl(remote, cache);
    final viewModel = ProductViewModel(repository);

    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductPage(viewModel: viewModel),
    );
  }
}