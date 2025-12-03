class LocalCar {
  final int id;
  final String model;
  final double price;

  LocalCar({
    required this.id,
    required this.model,
    required this.price,
  });

  factory LocalCar.fromJson(Map<String, dynamic> json) {
    final priceValue = json['price'];
    double parsedPrice;

    if (priceValue is int) {
      parsedPrice = priceValue.toDouble();
    } else if (priceValue is double) {
      parsedPrice = priceValue;
    } else if (priceValue is String) {
      parsedPrice = double.tryParse(priceValue.replaceAll(',', '.')) ?? 0.0;
    } else {
      parsedPrice = 0.0;
    }

    return LocalCar(
      id: int.parse(json['id'].toString()),
      model: json['model'] as String,
      price: parsedPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'price': price,
    };
  }
}
