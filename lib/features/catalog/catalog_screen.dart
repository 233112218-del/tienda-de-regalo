import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/polka_dot_background.dart';
import '../../core/widgets/product_artwork.dart';
import '../../features/cart/cart_provider.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';
import '../cart/cart_screen.dart';
import '../favorites/favorites_provider.dart';
import '../product_detail/product_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  static const _categories = ['Ramos', 'Carteras', 'Bolsos', 'Ropa'];
  static const _categoryIcons = [
    Icons.local_florist_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.shopping_bag_outlined,
    Icons.checkroom_outlined,
  ];

  final _repository = ProductRepository();
  final _searchController = TextEditingController();
  String _query = '';
  String? _selectedCategory;

  List<Product> get _visibleProducts =>
      _repository.getProducts().where((product) {
        final matchesCategory =
            _selectedCategory == null || product.category == _selectedCategory;
        final search = _query.toLowerCase();
        final matchesSearch =
            product.name.toLowerCase().contains(search) ||
            product.category.toLowerCase().contains(search);
        return matchesCategory && matchesSearch;
      }).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openCart() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final products = _visibleProducts;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        leading: const Padding(
          padding: EdgeInsets.only(left: 14),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline, color: AppColors.navy),
          ),
        ),
        title: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value.trim()),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Buscar regalos',
            prefixIcon: const Icon(Icons.search),
            contentPadding: EdgeInsets.zero,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, _) => IconButton(
              tooltip: 'Carrito',
              onPressed: _openCart,
              icon: Badge(
                isLabelVisible: cart.items.isNotEmpty,
                label: Text('${cart.items.length}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: PolkaDotBackground(
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Text(
                  'Explora por categoría',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 112,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final selected = category == _selectedCategory;
                    return SizedBox(
                      width: 76,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () => setState(
                          () => _selectedCategory = selected ? null : category,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: selected
                                  ? AppColors.navy
                                  : Colors.white,
                              child: Icon(
                                _categoryIcons[index],
                                color: selected ? Colors.white : AppColors.blue,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              category,
                              maxLines: 1,
                              style: const TextStyle(
                                color: AppColors.navy,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  _selectedCategory ?? 'Detalles para regalar',
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: products.isEmpty
                    ? const Center(
                        child: Text(
                          'No encontramos productos.',
                          style: TextStyle(color: AppColors.navy),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) =>
                            _ProductCard(product: products[index]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightBlue,
      borderRadius: BorderRadius.circular(26),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: ProductArtwork(
                          product: product,
                          icon: product.category == 'Ramos'
                              ? Icons.local_florist_outlined
                              : Icons.card_giftcard,
                        ),
                      ),
                    ),
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Consumer<FavoritesProvider>(
              builder: (context, favorites, _) {
                final isFavorite = favorites.isFavorite(product);
                return IconButton(
                  tooltip: isFavorite
                      ? 'Quitar de favoritos'
                      : 'Agregar a favoritos',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  onPressed: () =>
                      context.read<FavoritesProvider>().toggleFavorite(product),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.pinkAccent : AppColors.navy,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.85),
                    shape: const CircleBorder(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
