import 'package:demo/models/blog.dart';

abstract class BlogRepository {
  Future<List<BlogModel>>getPosts();


}