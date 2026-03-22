import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_app/provider/favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Favoritos"),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, _) {
              if (favoritesProvider.favorites.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                tooltip: "Limpar favoritos",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Limpar favoritos?"),
                        content: const Text("Deseja remover todos os favoritos?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () {
                              favoritesProvider.clearFavorites();
                              Navigator.pop(context);
                            },
                            child: const Text("Sim"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, _) {
          if (favoritesProvider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text("Nenhum produto favorito"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context); // ou voltar para home
                    },
                    child: const Text("Ver produtos"),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: favoritesProvider.favorites.length,
            itemBuilder: (context, index) {
              final product = favoritesProvider.favorites[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                  title: Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      favoritesProvider.removeFavorite(product.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
