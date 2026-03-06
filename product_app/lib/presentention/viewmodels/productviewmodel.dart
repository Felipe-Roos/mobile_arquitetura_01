import 'package:flutter/material.dart';
import 'package:product_app/domain/entities/product.dart';
import 'package:product_app/repositories/product_repository.dart';

class ProductViewmodel {
  final ProductRepository repository;

  final ValueNotifier<List<Product>> products = ValueNotifier([]);

  ProductViewmodel(this.repository);

  Future<void> loadProducts() async {
    final result = await repository.getProducts();
    products.value = result;
  }

}