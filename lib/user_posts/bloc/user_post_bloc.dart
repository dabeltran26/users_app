import 'package:bloc/bloc.dart';
import 'package:user_post/user_posts/bloc/user_post_event.dart';
import 'package:user_post/user_posts/bloc/user_post_state.dart';
import 'package:user_post/user_posts/model/post_model.dart';
import 'package:user_post/user_posts/repositories/post_repository.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {

  final PostRepository _userPostRepository;

  UserPostBloc(this._userPostRepository) : super( Initialized() ) {

    List<Post> postResult;

    on<Init>( (event, emit ) async {
      try{
        postResult = await _userPostRepository.fetchPosts(event.userId);
        emit(DataState(postResult));
      }catch(_){
        print('Error');
      }
    });

  }
}