import '../models/product_model.dart';

class ProductRepository {
  static const _giftImage = 'assets/images/regalo_azul.png';

  List<Product> getProducts() => const [
    Product(
      id: 'ramo-primavera',
      name: 'Ramo Primavera',
      category: 'Ramos',
      description:
          'Un ramo lleno de color para celebrar esos momentos que merecen '
          'quedarse en la memoria.',
      price: 520,
      imageAsset: _giftImage,
    ),
    Product(
      id: 'ramo-azul',
      name: 'Ramo Azul',
      category: 'Ramos',
      description:
          'Flores seleccionadas y envueltas con cariño en tonos azules.',
      price: 460,
      imageAsset: _giftImage,
    ),
    Product(
      id: 'cartera-clasica',
      name: 'Cartera Clásica',
      category: 'Carteras',
      description: 'Una cartera práctica y elegante, el detalle ideal para todos los días.',
      price: 380,
      imageAsset: _giftImage,
    ),
    Product(
      id: 'cartera-azul',
      name: 'Cartera Azul',
      category: 'Carteras',
      description:
          'Diseño atemporal en azul marino para llevar todo lo importante.',
      price: 420,
      imageAsset: _giftImage,
    ),
    Product(
      id: 'bolso-urbano',
      name: 'Bolso Urbano',
      category: 'Bolsos',
      description:
          'Un bolso versátil con espacio para acompañarte en cada aventura.',
      price: 690,
      imageAsset: _giftImage,
    ),
    Product(
      id: 'bolso-mini',
      name: 'Bolso Mini',
      category: 'Bolsos',
      description:
          'Un accesorio ligero y encantador para ocasiones especiales.',
      price: 550,
      imageAsset: _giftImage,
    ),
    Product(
      id: 'bufanda-suave',
      name: 'Bufanda Suave',
      category: 'Ropa',
      description: 'Suave al tacto y perfecta para regalar un abrazo en los días frescos.',
      price: 340,
      imageAsset: _giftImage,
    ),
    Product(
      id: 'sueter-comodo',
      name: 'Suéter Cómodo',
      category: 'Ropa',
      description: 'Una prenda cómoda y cálida para disfrutar cada temporada.',
      price: 780,
      imageAsset: _giftImage,
    ),
  ];
}
