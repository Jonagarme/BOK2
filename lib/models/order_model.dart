class Orders {
  String id;
  String customerName;
  String product;
  int quantity;
  double totalPrice;
  String status;

  Orders({
    required this.id,
    required this.customerName,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'product': product,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'status': status,
    };
  }

  static Orders fromMap(Map<String, dynamic> map, String id) {
    return Orders(
      id: id,
      customerName: map['customerName'],
      product: map['product'],
      quantity: map['quantity'],
      totalPrice: map['totalPrice'],
      status: map['status'],
    );
  }
}
