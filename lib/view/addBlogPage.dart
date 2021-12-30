import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
            )
          ],
        ),
      ),
    );
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
