import 'package:flutter/material.dart';
import 'package:user_post/home/model/user_model.dart';

@immutable
abstract class HomeState {
  const HomeState();
  @override
  List<Object> get props => [];
}

class Initialized extends HomeState{
  @override
  String toString() => 'Init';
}

class DataState extends HomeState{
  final List<User> users;
  const DataState(this.users);
  @override
  List<Object> get props => [users];

  @override
  String toString() => 'return users';
}

