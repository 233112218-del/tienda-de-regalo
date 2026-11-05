import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteProductIds = <String>{};

  Set<String> get favoriteProductIds => Set.unmodifiable(_favoriteProductIds);

  bool isFavorite(Product product) => _favoriteProductIds.contains(product.id);

  void toggleFavorite(Product product) {
    if (_favoriteProductIds.contains(product.id)) {
      _favoriteProductIds.remove(product.id);
    } else {
      _favoriteProductIds.add(product.id);
    }
    notifyListeners();
  }
}
