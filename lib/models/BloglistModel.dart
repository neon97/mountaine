import 'package:cloud_firestore/cloud_firestore.dart';

class BlogListModel {
  //!datatypes
  String? refernceId;
  String? bloggerName;
  String? description;
  String? image;
  bool? liked;
  int? likes;
  String? mountName;
  String? statement;

  //!constructors
  BlogListModel(
      {this.refernceId,
      this.bloggerName,
      this.description,
      this.image,
      this.liked,
      this.likes,
      this.mountName,
      this.statement});

  //!factory method
  factory BlogListModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return BlogListModel(
      refernceId: json["refID"] as String,
      bloggerName: json['bloggerName'] as String,
      description: json['description'] as String,
      statement: json['statement'] as String,
      image: json['image'] as String,
      liked: json['liked'] as bool,
      likes: json['likes'] as int,
      mountName: json['mountName'] as String,
    );
  }

  toJson() {
    return {
      "bloggerName": bloggerName,
      "description": description,
      "statement": statement,
      "image": image,
      "liked": liked,
      "likes": likes,
      "mountName": mountName
    };
  }

  //!factory snapshots
  factory BlogListModel.fromSnapshots(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    data.addAll({"refID": snapshot.id});
    final blog = BlogListModel.fromJson(data);
    return blog;
  }
}

class BlogListModelDataRepo {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('blogs');

  //! ---- CRUD Operation to my collection ------

//! create data
  createBlogData(BlogListModel data) async {
    await _collection.add(data.toJson());
  }

//! read data
  getBlogData() {
    return _collection.snapshots();
  }

//! update data
  updateBlogData(BlogListModel data) async {
    await _collection.doc(data.refernceId).update(data.toJson());
  }

//! delete data
  deleteBlogData(BlogListModel data) async {
    await _collection.doc(data.refernceId).delete();
  }
}
