import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:user_post/user_posts/model/post_model.dart';
import 'package:user_post/user_posts/repositories/post_repository.dart';
import 'package:user_post/utils/constants.dart';

import 'posts_api_test.mocks.dart';

class Client extends Mock implements http.Client {}

@GenerateMocks([Client])
void main() {
  String baseUrl = Constants.baseUrl;
  PostRepository postRepository = PostRepository();

  test('returns posts api', () async {
    var client = MockClient();
    final url = Uri.http(baseUrl,'/users');
    when(client.get(url))
        .thenAnswer((_) async => http.Response('', 200));
    expect(await postRepository.fetchPosts(1), isA<List<Post>>());
  });
}
