class BlogModel {
  String title;
  String description;
  String imageUrl;

  BlogModel({required this.title, required this.description, required this.imageUrl});

  factory BlogModel.fromJson(Map<String, dynamic> json){

    return BlogModel (
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],

    );
  }
}

