import 'blog_list.dart';

class BlogListModel {
  int? totalCount;
  String? message;
  List<BlogList>? blogList;
  String? status;

  BlogListModel({
    this.totalCount,
    this.message,
    this.blogList,
    this.status,
  });

  factory BlogListModel.fromJson(Map<String, dynamic> json) => BlogListModel(
        totalCount: json['TotalCount'] as int?,
        message: json['Message'] as String?,
        blogList: (json['BlogList'] as List<dynamic>?)
            ?.map((e) => BlogList.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: json['Status'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'TotalCount': totalCount,
        'Message': message,
        'BlogList': blogList?.map((e) => e.toJson()).toList(),
        'Status': status,
      };
}
