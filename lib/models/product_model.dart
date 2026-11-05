class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String imageAsset;
}
