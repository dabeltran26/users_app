import 'package:flutter/material.dart';
import 'package:user_post/user_posts/model/post_model.dart';
import 'package:user_post/utils/theme.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text(
                post.title,
                style: MyTheme.generalFonts.bold
                    .copyWith(color: MyTheme.generalColors.green),
              ),
              subtitle: Text(post.body)),
        ],
      ),
    );
  }
}
