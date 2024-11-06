import 'package:demo/models/blog.dart';
import 'package:test/test.dart';

void main(){
  group('BlogModel.formsjon', (){
    test('corretly convert json to BlogModel', (){
      final json = {
        'title': 'Blog Title',
        'description': 'This is a description of the blog post.',
        'image_url': 'https://imageupscaler.com/wp-content/uploads/2024/07/deblured-cutty-fox.jpg'
      };

      final blogModel = BlogModel.fromJson(json);

      expect(blogModel.title, 'Blog Title');
      expect(blogModel.description, 'This is a description of the blog post.');
      expect(blogModel.imageUrl, 'https://imageupscaler.com/wp-content/uploads/2024/07/deblured-cutty-fox.jpg');

    });
  });
}