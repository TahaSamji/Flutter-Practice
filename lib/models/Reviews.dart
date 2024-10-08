class Reviews {
  final String comment;

  Reviews({required this.comment});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(comment: json["comment"]);
  }
}
