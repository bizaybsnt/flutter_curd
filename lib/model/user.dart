class User {
  final String name;
  final String email;
  final int id;

  User(this.id, this.name, this.email);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  static User fromJson(Map<String, dynamic> data) {
    return User(data['id'], data["name"], data["email"]);
  }
}
