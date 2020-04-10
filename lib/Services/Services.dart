import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jsonparsingflutter/Model/User.dart';

class Services {
  static Future<List<User>> getUsers() async {
    const String url = "https://jsonplaceholder.typicode.com/users";
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body) as List;
        List<User> users = parsed.map((data) => User.fromJson(data)).toList();
        return users;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
