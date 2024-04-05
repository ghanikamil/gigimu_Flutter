import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  LoginResponseModel({
    required this.name,
    required this.email,
    required this.token,
  });

  final String name;
  final String email;
  final String token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json){
    return LoginResponseModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "token": token,
  };

  @override
  String toString(){
    return "$name, $email, $token, ";
  }

  @override
  List<Object?> get props => [
    name, email, token, ];

}