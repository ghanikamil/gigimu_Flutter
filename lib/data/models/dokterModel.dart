import 'package:equatable/equatable.dart';

class DokterModel extends Equatable {
  DokterModel({
    required this.dokterId,
    required this.nama,
    required this.spesialis,
    required this.email,
    required this.isSpesialis,
  });

  final int dokterId;
  final String nama;
  final String spesialis;
  final String email;
  final bool isSpesialis;

  factory DokterModel.fromJson(Map<String, dynamic> json){
    return DokterModel(
      dokterId: json["dokterID"] ?? 0,
      nama: json["nama"] ?? "",
      spesialis: json["spesialis"] ?? "",
      email: json["email"] ?? "",
      isSpesialis: json["isSpesialis"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "dokterID": dokterId,
    "nama": nama,
    "spesialis": spesialis,
    "email": email,
    "isSpesialis": isSpesialis,
  };

  @override
  String toString(){
    return "$dokterId, $nama, $spesialis, $email, $isSpesialis, ";
  }

  @override
  List<Object?> get props => [
    dokterId, nama, spesialis, email, isSpesialis, ];

}