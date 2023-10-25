class ItemModel {
  String? id;
  String? barcode;
  int? price;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  ItemModel(
    this.id,
    this.barcode,
    this.price,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  );

  ItemModel.fromJson(Map<String, dynamic> data) {
    id = data['id'] ?? '';
    barcode = data['barcode'] ?? '';
    price = data['price'] ?? 0;
    quantity = data['quantity'] ?? 0;
    createdAt = data['createdAt'] ?? '';
    updatedAt = data['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barcode':barcode,
      'price': price,
      'quantity': quantity,
      'createdAt':createdAt,
      'updatedAt':updatedAt,
    };
    
  }
}
