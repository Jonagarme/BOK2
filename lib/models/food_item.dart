class FoodItem {
  final String id;
  final String name;
  final double price;

  FoodItem({this.id = '', required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map, String documentId) {
    return FoodItem(
      id: documentId,
      name: map['name'],
      price: map['price'],
    );
  }
}
