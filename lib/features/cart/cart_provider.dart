import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class CartItem {
  const CartItem({
    required this.product,
    required this.recipient,
    required this.dedication,
  });

  final Product product;
  final String recipient;
  final String dedication;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice =>
      _items.fold(0, (total, current) => total + current.product.price);

  void addItem(
    Product product, {
    required String recipient,
    required String dedication,
  }) {
    _items.add(
      CartItem(product: product, recipient: recipient, dedication: dedication),
    );
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
