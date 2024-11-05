import 'package:demo/models/blog.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class PostsLoading extends BlogState {}

class PostsSucces extends BlogState {
    final List<BlogModel> posts;
  
  PostsSucces({ required this.posts});
}

class PostsError extends BlogState {
  final String errorMessage;

  PostsError(this.errorMessage);

}
