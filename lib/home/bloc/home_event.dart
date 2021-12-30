import 'package:flutter/material.dart';
import 'package:user_post/home/model/user_model.dart';

@immutable
abstract class HomeEvent {}

class Init extends HomeEvent{}

class SearchEvent extends HomeEvent{

  final String text;
  final List<User> users;
  SearchEvent(this.text, this.users);

  @override
  List<Object> get props => [];
}