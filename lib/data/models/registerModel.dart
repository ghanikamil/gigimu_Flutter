import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  RegisterModel({
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.email,
    required this.password,
    required this.repassword,
  });

  final String nama;
  final String alamat;
  final String telepon;
  final String email;
  final String password;
  final String repassword;

  factory RegisterModel.fromJson(Map<String, dynamic> json){
    return RegisterModel(
      nama: json["nama"] ?? "",
      alamat: json["alamat"] ?? "",
      telepon: json["telepon"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      repassword: json["repassword"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "alamat": alamat,
    "telepon": telepon,
    "email": email,
    "password": password,
    "repassword": repassword,
  };

  @override
  String toString(){
    return "$nama, $alamat, $telepon, $email, $password, $repassword, ";
  }

  @override
  List<Object?> get props => [
    nama, alamat, telepon, email, password, repassword, ];

}
