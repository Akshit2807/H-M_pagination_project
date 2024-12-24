class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      imageUrl: json['images']?[0]?['url'] ?? '',
      price: double.tryParse(json['price']?['value']?.toString() ?? '0') ?? 0.0,
    );
  }
}