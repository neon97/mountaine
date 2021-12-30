import 'package:cloud_firestore/cloud_firestore.dart';

class BlogListModel {
  //!datatypes
  String? bloggerName;

  //!constructors
  BlogListModel({this.bloggerName});

  //!factory method
  factory BlogListModel.fromJson(Map<String, dynamic> json) {
    return BlogListModel(bloggerName: json['bloggerName'] as String);
  }

  //!factory snapshots
  factory BlogListModel.fromSnapshots(DocumentSnapshot snapshot) {
    final blog =
        BlogListModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return blog;
  }
}

class BlogListModelDataRepo {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('blogs');

      //! ---- CRUD Operation to my collection ------

//! read data
  getBlogData() {
    return _collection.snapshots();
  }


//! create data

//! update data

//! delete data
}
