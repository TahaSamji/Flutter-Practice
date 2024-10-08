import 'package:flutter_application_1/models/Reviews.dart';

class Products {
  final int id;
  final String title;
  final List tags;
  final List<Reviews> reviews;
  Products(
      {required this.id,
      required this.title,
      required this.tags,
      required this.reviews});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json["id"],
      title: json["title"],
      tags: json["tags"],
      reviews: (json['reviews'] as List)
          .map((review) =>
              Reviews.fromJson(review)) // Parse reviews as List<Reviews>
          .toList(),
    );
  }
}
