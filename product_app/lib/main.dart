import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:product_app/data/models/datasourches/product_remote_datasource.dart';
import 'package:product_app/repositories/productrepositoryimpl.dart';
import 'package:product_app/presentation/pages/productpage.dart';
import 'package:product_app/presentation/viewmodels/productviewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = ProductRemoteDatasource(Dio());
    final repository = ProductRepositoryImpl(datasource);
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