import 'package:demo/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:demo/repositories/blog_repository.dart';

class BlogViewModel {
  BlogViewModel();
  
  final BlogRepository _blogRepository = BlogRepository();
  final ValueNotifier<List<BlogModel>> postsNotifier = ValueNotifier([]);

 void fetchPosts() async {
    final posts = await _blogRepository.getPosts();
    postsNotifier.value = posts;
  }

}
