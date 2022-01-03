import 'package:flutter/material.dart';
import 'package:projectflutter/constant.dart';
import 'package:projectflutter/models/BloglistModel.dart';

class BlogDetailPage extends StatefulWidget {
  final BlogListModel blogData;
  BlogDetailPage({required this.blogData});
  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  //! controllers
  BlogListModelDataRepo _blogFunction = BlogListModelDataRepo();
  final _statement = TextEditingController();
  BlogListModel? _blog;

  @override
  void initState() {
    _blog = widget.blogData;
    _statement.text = _blog!.statement ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_blog!.mountName!),
      ),
      body: ListView(
        children: [
//!image
          Container(
            alignment: Alignment.topCenter,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      _blog!.image!,
                    ))),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _blog!.bloggerName!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${_blog!.likes} Likes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
          ),

          TextFormField(
            controller: _statement,
            maxLines: 3,
          ),

//! delete button
          Visibility(
            visible: loginGlobalModel!.bloggerName! == _blog!.bloggerName!,
            child: ElevatedButton(
                onPressed: () async {
                  await _blogFunction.deleteBlogData(_blog!);
                  Navigator.pop(context);
                },
                child: Text("Delete")),
          ),

//!update button
          ElevatedButton(
              onPressed: () async {
                _blog!.statement = _statement.text;
                //! functionality for updating things

                await _blogFunction.updateBlogData(_blog!);
                Navigator.pop(context);
              },
              child: Text("Update"))
        ],
      ),
    );
  }
}
