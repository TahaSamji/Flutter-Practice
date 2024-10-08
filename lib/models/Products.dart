import 'package:flutter_application_1/models/Reviews.dart';

class Products {
  final int id;
  final String title;
  final List tags;
  final List<Reviews> reviews;
  final List images;
  Products(
      {required this.id,
      required this.title,
      required this.tags,
      required this.reviews,
      required this.images});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        id: json["id"],
        title: json["title"],
        tags: json["tags"],
        reviews: (json['reviews'] as List)
            .map((review) =>
                Reviews.fromJson(review)) // Parse reviews as List<Reviews>
            .toList(),
        images: json['images']);
  }
}
