import 'package:demo/bloc/blog_bloc.dart';
import 'package:demo/bloc/blog_state.dart';
import 'package:demo/bloc/blog_event.dart';
import 'package:demo/bloc/user_bloc.dart';
import 'package:demo/repositories/blog_repository.dart';
import 'package:demo/repositories/user_repository.dart';
import 'package:demo/widgets/blog_list.dart';
import 'package:demo/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  UserRepository userRepository = UserRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:  const Size.fromHeight(56),
          child: BlocProvider(
            create: (BuildContext context) => UserBloc(userRepository: userRepository),
            child: const LogoutButton()
          ),
      ),
      body: RepositoryProvider(
        create: (context) => getIt<BlogRepository>() ,
          child: BlocProvider(
          create: (BuildContext context) => BlogBloc(
            blogRepository: context.read<BlogRepository>(),
          )..add(GetPosts()),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: 
              BlocBuilder<BlogBloc, BlogState>(
                builder: (context, state) {
                  switch (state){
                    case PostsLoading():
                      return const Center(child: CircularProgressIndicator(),);
                    case PostsSucces():
                      final posts = state.posts;
                      return BlogList(posts: posts);
                      case PostsError():
                        final errorMessage = state.errorMessage;
                        return Text(errorMessage);
                      default:
                        return Container(); 
                  }
                },
              )

            )
        )
      )

    );
  }
}