class User {
  final String id;
  final String name;
  final String email;
  final String rfc;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.rfc,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      rfc: json['rfc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'rfc': this.rfc,
    };
  }
}
