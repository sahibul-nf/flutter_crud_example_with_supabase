class ProductModel {
  final int? id;
  final String? name;
  final int? price;
  final String? createdAt;

  ProductModel({this.id, this.name, this.price, this.createdAt});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      createdAt: json['created_at'],
    );
  }
}
