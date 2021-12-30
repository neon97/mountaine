class BlogList {
  String? blogId;
  String? bloggerName;
  String? bloggerId;
  String? likes;
  String? liked;
  String? latitude;
  String? longitude;
  String? mountain;
  String? shortDescription;
  String? wordsByBlogger;
  String? postTime;
  String? image;

  BlogList({
    this.blogId,
    this.bloggerName,
    this.bloggerId,
    this.likes,
    this.liked,
    this.latitude,
    this.longitude,
    this.mountain,
    this.shortDescription,
    this.wordsByBlogger,
    this.postTime,
    this.image,
  });

  factory BlogList.fromJson(Map<String, dynamic> json) => BlogList(
        blogId: json['BlogID'] as String?,
        bloggerName: json['BloggerName'] as String?,
        bloggerId: json['BloggerID'] as String?,
        likes: json['Likes'] as String?,
        liked: json['Liked'].toString(),
        latitude: json['Latitude'] as String?,
        longitude: json['Longitude'] as String?,
        mountain: json['Mountain'] as String?,
        shortDescription: json['ShortDescription'] as String?,
        wordsByBlogger: json['WordsByBlogger'] as String?,
        postTime: json['PostTime'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'BlogID': blogId,
        'BloggerName': bloggerName,
        'BloggerID': bloggerId,
        'Likes': likes,
        'Liked': liked,
        'Latitude': latitude,
        'Longitude': longitude,
        'Mountain': mountain,
        'ShortDescription': shortDescription,
        'WordsByBlogger': wordsByBlogger,
        'PostTime': postTime,
        'image': image,
      };
}
