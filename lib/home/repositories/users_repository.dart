import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/utils/constants.dart';

class UserRepository {
  final String baseUrl;

  UserRepository({this.baseUrl = Constants.baseUrl});

  Future<List<User>> fetchUsers() async {
    final uri = Uri.http(baseUrl,'/users');
    final response = await http.get(uri);

    if (json.decode(response.body) != null) {
      final List<dynamic> data = json.decode(response.body);
      final List<User> users = [];

      for (int i = 0; i < data.length; i++) {
        users.add(User.fromJson(data[i]));
      }
      return users;
    } else {
      return [];
    }
  }
}
