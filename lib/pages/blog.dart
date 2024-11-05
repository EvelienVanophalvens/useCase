import 'package:demo/bloc/blog_bloc.dart';
import 'package:demo/bloc/blog_state.dart';
import 'package:demo/bloc/blog_event.dart';
import 'package:demo/repositories/blog_repository.dart';
import 'package:demo/viewModels/user_view_model.dart';
import 'package:demo/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  UserRepository userRepository = UserRepository();
  late  final userViewModel = UserViewModel(userRepository);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async{
              final state = await userViewModel.logout();
              switch(state){
                case LogoutSucces():
                Navigator.of(context).pop();
                case LogoutFailed():
              }
            }, 
            icon: const Icon(Icons.logout))
        ],
      ),
      body: RepositoryProvider(
        create: (context) => BlogRepository(),
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
                      return 
                        ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index){
                          final post = posts[index];
                          return
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: 
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold),),
                                      Text(post.description),  
                                      const SizedBox(height: 10),
                                      Image.network(post.imageUrl, width: double.infinity, height: 100,),
                                    ],
                                )
                            );
                          }
                        );
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