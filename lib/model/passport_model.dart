import 'package:baas_study/model/profile_model.dart';

class LoginModel {
  int code;
  String token;
  String download;
  UserModel info;
  String msg;

  LoginModel({
    this.code,
    this.token,
    this.download,
    this.info,
    this.msg,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'],
      token: json['token'],
      download: json['download'],
      info: json['info'] != null ? new UserModel.fromJson(json['info']) : null,
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['token'] = this.token;
    data['download'] = this.download;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}
