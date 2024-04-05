import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel({
    required this.pasienId,
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.email,
  });

  final int pasienId;
  final String nama;
  final String alamat;
  final String telepon;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      pasienId: json["pasienID"] ?? 0,
      nama: json["nama"] ?? "",
      alamat: json["alamat"] ?? "",
      telepon: json["telepon"] ?? "",
      email: json["email"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "pasienID": pasienId,
    "nama": nama,
    "alamat": alamat,
    "telepon": telepon,
    "email": email,
  };

  @override
  String toString(){
    return "$pasienId, $nama, $alamat, $telepon, $email, ";
  }

  @override
  List<Object?> get props => [
    pasienId, nama, alamat, telepon, email, ];

}