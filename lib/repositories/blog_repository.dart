import 'dart:convert';
import 'package:demo/models/blog.dart';
import 'package:http/http.dart' as http;

class BlogRepository {
  final String baseUrl = "http://10.0.2.2:3001/v1";

  Future<List<BlogModel>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/blog/posts'),
      headers: {'content-type' : 'application/json'},
    );

     if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
       return jsonData
          .map<BlogModel>((post) => BlogModel.fromJson(post))
          .toList();
  } else {
    throw Exception('Failed to load posts');
  }

  }  

}