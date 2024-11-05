import 'package:demo/bloc/blog_bloc.dart';
import 'package:demo/bloc/blog_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogList extends StatelessWidget {
  final List posts;

  const BlogList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return 
    RefreshIndicator(
        onRefresh: () async {
        context.read<BlogBloc>().add(GetPosts());
        return Future.delayed(const Duration(seconds: 1));
      },
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
}