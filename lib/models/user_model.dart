class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String street;
  final String city;
  final String website;
  final String companyName;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.street,
    required this.city,
    required this.website,
    required this.companyName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      street: json['address']?['street'] ?? '',
      city: json['address']?['city'] ?? '',
      website: json['website'] ?? '',
      companyName: json['company']?['name'] ?? '',
    );
  }
}
