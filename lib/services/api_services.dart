import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riddhi_task/models/user_model.dart';
import '../models/post_model.dart';

class ApiService {
  static Future<List<UserModel>> fetchUsers() async {
    final url = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115 Safari/537.36',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch users. Status: ${response.statusCode}");
    }
  }

  static Future<List<PostModel>> fetchPosts(int userId) async {
    final url = 'https://jsonplaceholder.typicode.com/posts?userId=$userId';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115 Safari/537.36',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch posts. Status: ${response.statusCode}");
    }
  }
}
