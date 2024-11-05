import 'package:demo/viewModels/blog_view_model.dart';
import 'package:demo/viewModels/user_view_model.dart';
import 'package:demo/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final blogViewModel = BlogViewModel();
  UserRepository userRepository = UserRepository();
  late  final userViewModel = UserViewModel(userRepository);

  @override
  void initState() {
    super.initState();
    blogViewModel.fetchPosts();

  }

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
      body: ValueListenableBuilder(
        valueListenable: blogViewModel.postsNotifier, 
        builder: (context, posts, child){
          return 
          Padding(
            padding: const EdgeInsets.all(22),
            child: ListView.builder(
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
            )
          );
        }
      )
    );
  }
}