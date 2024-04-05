import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  LoginModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      email: json["email"] ?? "",
      password: json["password"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };

  @override
  String toString(){
    return "$email, $password, ";
  }

  @override
  List<Object?> get props => [
    email, password, ];

}