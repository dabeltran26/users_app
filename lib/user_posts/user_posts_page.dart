import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/user_posts/bloc/user_post_bloc.dart';
import 'package:user_post/user_posts/bloc/user_post_event.dart';
import 'package:user_post/user_posts/bloc/user_post_state.dart';
import 'package:user_post/user_posts/repositories/post_repository.dart';
import 'package:user_post/user_posts/widgets/post_widget.dart';
import 'package:user_post/utils/theme.dart';

class UserPostPage extends StatefulWidget {
  final User? user;
  const UserPostPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserPostPageState createState() => _UserPostPageState();
}

class _UserPostPageState extends State<UserPostPage> {
  PostRepository userPostRepository = PostRepository();
  late UserPostBloc? userBloc;

  @override
  void initState() {
    userBloc = UserPostBloc(userPostRepository)..add(Init(widget.user!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size padding = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyTheme.generalColors.white,
        body: BlocBuilder(
          bloc: userBloc,
          builder: (context, state) {
            if (state is DataState) {
              return Stack(children: [
                SafeArea(
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(15),
                        elevation: 10,
                        shadowColor: MyTheme.generalColors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(widget.user!.name,
                            style: MyTheme.generalFonts.bold
                                .copyWith(color: MyTheme.generalColors.green)),
                              Text(widget.user!.email,
                                  style: MyTheme.generalFonts.bold
                                      .copyWith(color: MyTheme.generalColors.green)),
                              Text(widget.user!.phone,
                                  style: MyTheme.generalFonts.bold
                                      .copyWith(color: MyTheme.generalColors.green)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.post.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PostCard(
                                post: state.post[index],
                              );
                            }),
                      )
                    ],
                  ),
                ),
                state.post.isEmpty
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
}
