class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime birthDate;
  final String street;
  final String companyname;
  final String latitude;

  User(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.birthDate,
      required this.street,
      required this.companyname,
      required this.latitude});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        birthDate: DateTime.parse(json["birthDate"]),
        street: json["address"]["street"],
        companyname: json["company"]["name"],
        latitude: json["address"]["geo"]["lat"]);
  }
}
