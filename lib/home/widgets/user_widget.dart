import 'package:flutter/material.dart';
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/user_posts/user_posts_page.dart';
import 'package:user_post/utils/assets.dart';
import 'package:user_post/utils/theme.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

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
                user.name,
                style: MyTheme.generalFonts.bold
                    .copyWith(color: MyTheme.generalColors.green),
              ),
              subtitle: Column(children: [
                _itemText(user.phone, Assets.icons.phone),
                const SizedBox(
                  height: 5,
                ),
                _itemText(user.email, Assets.icons.mail)
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserPostPage(user: user,)),
                        )
                      },
                  child: Text(
                    'Ver publicaciones',
                    style: MyTheme.generalFonts.large
                        .copyWith(color: MyTheme.generalColors.green),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _itemText(String text, String asset) {
    return Row(
      children: [
        Image.asset(
          asset,
          width: 18,
          color: MyTheme.generalColors.green,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(text, style: MyTheme.generalFonts.medium),
      ],
    );
  }
}
