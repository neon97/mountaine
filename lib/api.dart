//!Staging => development
//!production => live

String _api = "servercheckup.herokuapp.com";

Uri loginApi(String mobile, String password) =>
    Uri.https(_api, 'login', {'mobile': mobile, 'password': password});

Uri blogsApi = Uri.https(
  _api,
  'blogs',
);
