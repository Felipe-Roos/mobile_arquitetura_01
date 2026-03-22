import 'package:flutter/foundation.dart';
import 'package:product_app/domain/entities/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  bool isFavorite(int productId) {
    return _favorites.any((product) => product.id == productId);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product.id)) {
      _favorites.removeWhere((p) => p.id == product.id);
      print('❌ Removido do favorito: ${product.title}');
    } else {
      _favorites.add(product.copyWith(isFavorite: true));
      print('❤️ Adicionado aos favoritos: ${product.title}');
    }
    print('📊 Total de favoritos: ${_favorites.length}');
    notifyListeners();
  }

  void addFavorite(Product product) {
    if (!isFavorite(product.id)) {
      _favorites.add(product.copyWith(isFavorite: true));
      print('❤️ Adicionado aos favoritos: ${product.title}');
      notifyListeners();
    }
  }

  void removeFavorite(int productId) {
    _favorites.removeWhere((product) => product.id == productId);
    print('❌ Removido do favorito - ID: $productId');
    notifyListeners();
  }

  void clearFavorites() {
    print('🗑️ Limpando todos os favoritos');
    _favorites.clear();
    notifyListeners();
  }
}
