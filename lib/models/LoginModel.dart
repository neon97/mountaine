class LoginModel {
  String? bloggerId;
  String? bloggerName;
  String? email;
  String? image;
  String? messageinfo;
  String? status;

  LoginModel({
    this.bloggerId,
    this.bloggerName,
    this.email,
    this.image,
    this.messageinfo,
    this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        bloggerId: json['BloggerID'] as String?,
        bloggerName: json['BloggerName'] as String?,
        email: json['Email'] as String?,
        image: json['Image'] as String?,
        messageinfo: json['Messageinfo'] as String?,
        status: json['Status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'BloggerID': bloggerId,
        'BloggerName': bloggerName,
        'Email': email,
        'Image': image,
        'Messageinfo': messageinfo,
        'Status': status,
      };
}
