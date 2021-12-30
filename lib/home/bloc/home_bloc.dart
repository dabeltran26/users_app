import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:user_post/home/bloc/home_event.dart';
import 'package:user_post/home/bloc/home_state.dart';
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/home/repositories/users_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final UserRepository? _userRepository;
  final Function(List<User> users)  refreshCallback;
  var usersBox = Hive.box('usersBox');

  HomeBloc(this._userRepository, this.refreshCallback) : super( Initialized() ) {

    List<User> userResult = [];
    List<dynamic> userDB = [];

    on<Init>( (event, emit ) async {
      try{
        if(usersBox.get('users') != null){
          userDB = usersBox.get('users');
          for (int i = 0; i < userDB.length; i++) {
            userResult.add(userDB[i]);
          }
          emit(DataState(userResult));
        }else{
          userResult = await _userRepository!.fetchUsers();
          usersBox.put('users', userResult);
          emit(DataState(userResult));
        }
      }catch(_){
        print('Error');
      }
    });

    on<SearchEvent>( (event, emit ) async {
        List<User> filterUsers = userResult.where((i) => i.name.contains(event.text)).toList();
        if(filterUsers.isEmpty){
          refreshCallback.call([]);
        }else{
          refreshCallback.call(filterUsers);
        }
    });


  }
}