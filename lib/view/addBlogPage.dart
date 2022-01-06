import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectflutter/constant.dart';
import 'package:projectflutter/controller/blogListCrontroller.dart';
import 'package:projectflutter/controller/storageController.dart';
import 'package:projectflutter/models/BloglistModel.dart';
import 'package:projectflutter/view/homescreen.dart';
import 'package:projectflutter/widgets/loader.dart';
import 'package:projectflutter/widgets/popup.dart';

class AddBlogPage extends StatefulWidget {
  @override
  _AddBlogPageState createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  //!datatype
  XFile? _image;

  //!functions
  getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: source);
    setState(() {});
  }

  //!controllers
  final description = TextEditingController();
  final image = TextEditingController();
  final mountName = TextEditingController();
  final statement = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Blog"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),

//!image
            Container(
              alignment: Alignment.center,
              color: Colors.blue[50],
              height: 200,
              child: _image == null
                  ? _accesImage()
                  : GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: _accesImage(),
                              )),
                      child: Image.file(File(_image!.path))),
            ),

//!mountain name
            TextFormField(
              controller: mountName,
              decoration: InputDecoration(labelText: "Mount Name"),
            ),

//!description
            TextFormField(
              controller: description,
              maxLines: 3,
              decoration: InputDecoration(labelText: "Description"),
            ),

//!statments
            TextFormField(
              controller: statement,
              maxLines: 3,
              decoration: InputDecoration(labelText: "Statements"),
            ),

//!create button
            ElevatedButton(
                onPressed: () async {
                  var imageUrl = await _uploadingImageSection();
                  BlogListModel _blog = BlogListModel(
                      description: description.text,
                      image: imageUrl,
                      liked: false,
                      likes: 0,
                      mountName: mountName.text,
                      statement: statement.text,
                      bloggerName: "Akhand");
                  BlogListModelDataRepo _blogController =
                      BlogListModelDataRepo();
                  await _blogController.createBlogData(_blog);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Homescreenpage()));
                },
                child: Text("Post Blog"))
          ],
        ),
      ),
    );
  }

  _uploadingImageSection() async {
    StorageModule _uploader = StorageModule(storage);
    loader(context);
    var response =
        await _uploader.uploadImage(File(_image!.path), _image!.name);
    if (response is TaskSnapshot) {
      var url = await _uploader.getUrlOfUploadedImage(response);
      return url;
    } else if (response is FirebaseException) {
      popup(context, response.message!);
    }
  }

  Widget _accesImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              getImage(ImageSource.camera);
            },
            icon: Icon(
              Icons.camera,
              size: 40,
            )),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            icon: Icon(
              Icons.image,
              size: 40,
            )),
      ],
    );
  }
}
