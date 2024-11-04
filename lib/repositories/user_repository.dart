import 'dart:convert';
import 'package:http/http.dart' as http;

class Userrepository {
  final String baseUrl = "http://10.0.2.2:3001/v1";

  Future<Map<String,dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'content-type' : 'application/json'},
      body: jsonEncode({'username':username, 'password':password})
    );
    return {
      'statusCode': response.statusCode,
      'body': response.body,
    };
  }

  Future<Map<String,dynamic>> logout() async{
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'content-type': 'application/json'}
    );
    return{
      'statusCode': response.statusCode
    };
  }
}