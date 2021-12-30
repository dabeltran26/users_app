import 'package:flutter/material.dart';
import 'package:user_post/user_posts/model/post_model.dart';

@immutable
abstract class UserPostEvent {}

class Init extends UserPostEvent{
  final int userId;
  Init(this.userId);
}

class UpdateEvent extends UserPostEvent{
  final List<Post> post;
  final String text;
  UpdateEvent(this.post, this.text);

  @override
  List<Object> get props => [];
}