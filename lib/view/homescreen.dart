import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectflutter/models/BloglistModel.dart';
import 'package:projectflutter/models/LoginModel.dart';
import 'package:projectflutter/view/addBlogPage.dart';
import 'package:projectflutter/view/blogDetailScreen.dart';
import 'package:projectflutter/view/settingsPage.dart';

class Homescreenpage extends StatefulWidget {
  final LoginModel loginModel;
  Homescreenpage({required this.loginModel});
  @override
  _HomescreenpageState createState() => _HomescreenpageState();
}

class _HomescreenpageState extends State<Homescreenpage> {
//! models
  BlogListModelDataRepo _blogRepo = BlogListModelDataRepo();

  @override
  Widget build(BuildContext context) {
    print("calling the homescreen state");
    return Scaffold(
      appBar: AppBar(
        title: Text("Hompage"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat))],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
              //! who builds the contimius flow data and it renders it to the ui
              stream: _blogRepo.getBlogData(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snap.hasData) {
                  if (snap.data!.docs.isEmpty)
                    return Center(
                      child: Text("No Blogs Added Yet !!"),
                    );
                  else
                    return _buildList(snap.data!.docs);
                  //! snap.data is a collection names as blogs
                  //! blogs i am calling docs
                  //! docs will give me the list of data
                } else {
                  return Center(
                    child: Text("${snap.error}"),
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddBlogPage()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      drawer: _drawer(),
    );
  }

  Widget _buildList(List<DocumentSnapshot>? snapshot) {
    return ListView.builder(
        itemCount: snapshot!.length,
        itemBuilder: (context, i) {
          return _tile(snapshot[i]);
        });
  }

  _drawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.loginModel.image!),
              ),
              accountName: Text(widget.loginModel.bloggerName!),
              accountEmail: Text(widget.loginModel.email!)),
          ListTile(
            title: Text("Home Page"),
            leading: Icon(Icons.home),
          ),
          ListTile(
            title: Text("Trending Page"),
            leading: Icon(Icons.trending_up),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            title: Text("Settings Page"),
            leading: Icon(Icons.settings),
          ),
          ListTile(
            title: Text("About Page"),
            leading: Icon(Icons.person),
          )
        ],
      ),
    );
  }

//!separate widgets
  _tile(DocumentSnapshot snapshot) {
    final blog = BlogListModel.fromSnapshots(snapshot);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlogDetailPage(blogData: blog)));
        },
        child: Container(
          height: 220,
          child: Column(
            children: [
              //!image
              Container(
                alignment: Alignment.topCenter,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          blog.image!,
                        ))),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 13,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            blog.bloggerName!,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            blog.liked = !blog.liked!;
                            await _blogRepo.updateBlogData(blog);
                          },
                          icon: Icon(
                            blog.liked! == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                height: 70,
                color: Colors.white,
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    //! icon,mountainname,datepost
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.train),
                            Text(blog.mountName!),
                          ],
                        ),
                      ],
                    ),

                    //!mountainerr words
                    Text(
                      blog.statement!,
                      overflow: TextOverflow.ellipsis,
                    ),

                    //!mountain detail
                    Text(
                      blog.description!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
