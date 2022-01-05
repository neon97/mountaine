import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectflutter/models/BloglistModel.dart';

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
