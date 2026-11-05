import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/polka_dot_background.dart';
import '../../core/widgets/product_artwork.dart';
import '../cart/cart_provider.dart';
import '../cart/cart_screen.dart';
import '../favorites/favorites_provider.dart';
import '../../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _dedicationController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _dedicationController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    context.read<CartProvider>().addItem(
      widget.product,
      recipient: _recipientController.text.trim(),
      dedication: _dedicationController.text.trim(),
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favorites, _) {
              final isFavorite = favorites.isFavorite(product);
              return IconButton(
                tooltip: isFavorite
                    ? 'Quitar de favoritos'
                    : 'Agregar a favoritos',
                onPressed: () =>
                    context.read<FavoritesProvider>().toggleFavorite(product),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.pinkAccent : AppColors.navy,
                ),
              );
            },
          ),
        ],
      ),
      body: PolkaDotBackground(
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
              children: [
                Container(
                  height: 245,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  padding: const EdgeInsets.all(28),
                  child: ProductArtwork(
                    product: product,
                    icon: product.category == 'Ramos'
                        ? Icons.local_florist_outlined
                        : Icons.card_giftcard,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  product.name,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  product.description,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  controller: _recipientController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(hintText: 'Para:'),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Escribe para quién es el regalo.'
                      : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _dedicationController,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(hintText: 'Dedicatoria:'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(22, 8, 22, 18),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _continue,
            child: const Text('Continuar'),
          ),
        ),
      ),
    );
  }
}
