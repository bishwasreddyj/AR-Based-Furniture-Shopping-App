class Productmodel {
  String title;
  String productId;
  String description;
  double price;

  List<String> images = [];
  String arModel;

  Productmodel({
    required this.arModel,
    required this.description,
    required this.images,
    required this.price,
    required this.productId,
    required this.title,
  });

  factory Productmodel.fromJson(Map<String, dynamic> json) {
    return Productmodel(
      arModel: json['arModel'],
      description: json['description'],
      images: List<String>.from(json['images']),
      price: json['price'].toDouble(),
      title: json['title'],
      productId: json["_id"],
    );
  }
}
