import 'package:equatable/equatable.dart';

class JadwalModel extends Equatable {
  JadwalModel({
    required this.jadwalDokterId,
    required this.tanggal,
    required this.maxOrang,
    required this.status,
    required this.pasienTerdaftar,
  });

  final int jadwalDokterId;
  final DateTime? tanggal;
  final int maxOrang;
  final String status;
  final int pasienTerdaftar;

  factory JadwalModel.fromJson(Map<String, dynamic> json){
    return JadwalModel(
      jadwalDokterId: json["jadwalDokterID"] ?? 0,
      tanggal: DateTime.tryParse(json["tanggal"] ?? ""),
      maxOrang: json["maxOrang"] ?? 0,
      status: json["status"] ?? "",
      pasienTerdaftar: json["pasienTerdaftar"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "jadwalDokterID": jadwalDokterId,
    "tanggal": tanggal?.toIso8601String(),
    "maxOrang": maxOrang,
    "status": status,
    "pasienTerdaftar": pasienTerdaftar,
  };

  @override
  String toString(){
    return "$jadwalDokterId, $tanggal, $maxOrang, $status, $pasienTerdaftar, ";
  }

  @override
  List<Object?> get props => [
    jadwalDokterId, tanggal, maxOrang, status, pasienTerdaftar, ];

}

