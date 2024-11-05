import 'package:flutter_bloc/flutter_bloc.dart';
import 'blog_state.dart';
import 'blog_event.dart';
import 'package:demo/repositories/blog_repository.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState>{
  final BlogRepository blogRepository;

  BlogBloc({required this.blogRepository}) : super(BlogInitial()){   on<GetPosts>(mapEventToState);}

  void mapEventToState(BlogEvent event, Emitter<BlogState> emit) async{
    try{
      emit(PostsLoading());
      final posts = await blogRepository.getPosts();
      emit(PostsSucces(posts: posts));
    }catch(e){
      emit(PostsError("There was an error"));
    }
  }
}