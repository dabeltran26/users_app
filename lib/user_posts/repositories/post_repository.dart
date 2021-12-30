import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_post/user_posts/model/post_model.dart';
import 'package:user_post/utils/constants.dart';

class PostRepository{

  final String baseUrl;

  PostRepository({
    this.baseUrl = Constants.baseUrl
  });

  Future<List<Post>> fetchPosts(int userId) async {

    final params = {
      'userId': userId.toString(),
    };

    final uri = Uri.http(baseUrl,'/posts',params);
    final response = await http.get(uri);

    if (json.decode(response.body) != null) {
      final List<dynamic> data = json.decode(response.body);
      final List<Post> posts = [];
      for (int i = 0; i < data.length; i++) {
        posts.add(Post.fromJson(data[i]));
      }
      return posts;
    } else {
      return [];
    }
  }
}