class ServiceModel {
  final String id;
  final String name;
  final String? description;
  final int price;
  final DateTime createdAt;

  ServiceModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.createdAt,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['\$id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      price: map['price'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
