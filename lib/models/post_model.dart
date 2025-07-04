import 'dart:convert';

class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
  };

  static String encode(List<PostModel> posts) =>
      json.encode(posts.map((e) => e.toJson()).toList());

  static List<PostModel> decode(String jsonStr) =>
      (json.decode(jsonStr) as List<dynamic>)
          .map((e) => PostModel.fromJson(e))
          .toList();
}
