import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../theme/app_theme.dart';

class ProductArtwork extends StatelessWidget {
  const ProductArtwork({
    required this.product,
    this.icon = Icons.card_giftcard,
    super.key,
  });

  final Product product;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      product.imageAsset,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          Icon(icon, size: 72, color: AppColors.navy),
    );
  }
}
