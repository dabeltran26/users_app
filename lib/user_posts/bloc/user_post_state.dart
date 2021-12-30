import 'package:flutter/material.dart';
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/user_posts/model/post_model.dart';

@immutable
abstract class UserPostState {
  const UserPostState();
  @override
  List<Object> get props => [];
}

class Initialized extends UserPostState{
  @override
  String toString() => 'Init';
}

class DataState extends UserPostState{
  final List<Post> post;
  const DataState(this.post);
  @override
  List<Object> get props => [post];

  @override
  String toString() => 'return users';
}

