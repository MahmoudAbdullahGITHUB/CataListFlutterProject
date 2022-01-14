class LoginResponse {
  String? message;
  bool? isSuccess;
  UserResponse? response;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSuccess = json['isSuccess'];
    response = json['response'] != null
        ? UserResponse.fromJson(json['response'])
        : null;
  }
}

class UserResponse {
  User? user;

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? userId;
  String? fullName;
  String? userEmail;
  String? userTelephone;
  String? token;
  String? refreshToken;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    userEmail = json['userEmail'];
    userTelephone = json['userTelephone'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
}
