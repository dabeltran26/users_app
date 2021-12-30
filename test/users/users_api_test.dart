import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/home/repositories/users_repository.dart';
import 'package:user_post/utils/constants.dart';

import 'users_api_test.mocks.dart';

class Client extends Mock implements http.Client {}

@GenerateMocks([Client])
void main() {
  String baseUrl = Constants.baseUrl;
  UserRepository userRepository = UserRepository();

  test('returns users api', () async {
    var client = MockClient();
    final url = Uri.http(baseUrl,'/users');
    when(client.get(url))
        .thenAnswer((_) async => http.Response('', 200));
    expect(await userRepository.fetchUsers(), isA<List<User>>());
  });
}
