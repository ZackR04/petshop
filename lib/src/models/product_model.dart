// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'models.dart';

class ListProductModel {
  final List<ProductModel> products;
  ListProductModel({
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory ListProductModel.fromMap(Map<String, dynamic> map) {
    return ListProductModel(
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListProductModel.fromJson(String source) =>
      ListProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductModel {
  final String? id;
  final DateTime? dateTime;
  final String? name;
  final double? price;
  final String? picture;
  final String? desc;
  ProductModel({
    this.id,
    this.dateTime,
    this.name,
    this.price,
    this.picture,
    this.desc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'name': name,
      'price': price,
      'picture': picture,
      'desc': desc,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int)
          : null,
      name: map['name'] != null ? map['name'] as String : 'none',
      price: map['price'] != null ? map['price'] as double : 0.0,
      picture: map['picture'] != null
          ? map['picture'] as String
          : "https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg",
      desc: map['desc'] != null ? map['desc'] as String : 'none',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductModel copyWith({
    String? id,
    DateTime? dateTime,
    String? name,
    double? price,
    String? picture,
    String? desc,
  }) {
    return ProductModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      name: name ?? this.name,
      price: price ?? this.price,
      picture: picture ?? this.picture,
      desc: desc ?? this.desc,
    );
  }
}
