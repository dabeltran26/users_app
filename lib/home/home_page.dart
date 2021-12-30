import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_post/home/bloc/home_bloc.dart';
import 'package:user_post/home/bloc/home_event.dart';
import 'package:user_post/home/bloc/home_state.dart';
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/home/repositories/users_repository.dart';
import 'package:user_post/home/widgets/user_widget.dart';
import 'package:user_post/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepository userRepository = UserRepository();
  late HomeBloc? _homeBloc;
  TextEditingController? controllerSearchField;
  List<User>? myUsers;

  @override
  void initState() {
    _homeBloc = HomeBloc(userRepository,refreshUsers)..add(Init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size padding = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyTheme.generalColors.white,
        appBar: AppBar(
          backgroundColor: MyTheme.generalColors.green,
          title: const Text('Prueba De Ingreso'),
        ),
        body: BlocBuilder(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is DataState) {
              myUsers = myUsers ?? state.users;
              return Stack(children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: padding.width * 0.30,
                          right: padding.width * 0.30,
                          top: padding.height * 0.02,
                          bottom: padding.height * 0.02),
                      alignment: Alignment.center,
                      child: TextField(
                        cursorColor: MyTheme.generalColors.green,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar usuario',
                          hintStyle: TextStyle(
                              color:
                                  MyTheme.generalColors.grey.withOpacity(0.5)),
                        ),
                        controller: controllerSearchField,
                        style: TextStyle(color: MyTheme.generalColors.black),
                        onChanged: (input) {
                          _homeBloc?.add(SearchEvent(input,myUsers!));
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: myUsers!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return UserCard(user: myUsers![index],);
                          }),
                    )
                  ],
                ),
                myUsers!.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        child: Text(
                          "No hay coincidencias.",
                          style: TextStyle(color: MyTheme.generalColors.black),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(),
              ]);
            }

            return Center(
                child: CircularProgressIndicator(
              backgroundColor: MyTheme.generalColors.green,
            ));
          },
        ));
  }

  void refreshUsers(List<User> users) {
    myUsers = users;
    setState(() {});
  }
}
