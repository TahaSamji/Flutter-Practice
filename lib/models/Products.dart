class Products {
  final int id;
  final String title;
  final List tags;
  Products({required this.id, required this.title, required this.tags});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(id: json["id"], title: json["title"], tags: json["tags"]);
  }
}
