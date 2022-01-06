import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

var storage = FirebaseStorage.instance;

class StorageModule {
  final FirebaseStorage _firebaseStorage;

  StorageModule(this._firebaseStorage);

  //! upload image
  uploadImage(File file, String filename) async {
    try {
      var response =
          await _firebaseStorage.ref().child('post/$filename').putFile(file);
      return response;
    } on FirebaseException catch (e) {
      print(e.message);
      return e;
    }
  }

  //! dleteing function
  deleteFile(String filename) async {
    try {
      await _firebaseStorage.ref().child('post/$filename').delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  //!get url of uploaded image
  getUrlOfUploadedImage(TaskSnapshot snap) async {
    try {
      var response = await snap.ref.getDownloadURL();
      return response;
    } on FirebaseException catch (e) {
      return e;
    }
  }
}
