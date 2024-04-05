import 'package:equatable/equatable.dart';

class MyBookModel extends Equatable {
  MyBookModel({
    required this.bookingId,
    required this.jamBooking,
    required this.jadwal,
    required this.dokter,
  });

  final int bookingId;
  final DateTime? jamBooking;
  final Jadwal? jadwal;
  final Dokter? dokter;

  factory MyBookModel.fromJson(Map<String, dynamic> json){
    return MyBookModel(
      bookingId: json["bookingID"] ?? 0,
      jamBooking: DateTime.tryParse(json["jamBooking"] ?? ""),
      jadwal: json["jadwal"] == null ? null : Jadwal.fromJson(json["jadwal"]),
      dokter: json["dokter"] == null ? null : Dokter.fromJson(json["dokter"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "bookingID": bookingId,
    "jamBooking": jamBooking?.toIso8601String(),
    "jadwal": jadwal?.toJson(),
    "dokter": dokter?.toJson(),
  };

  @override
  String toString(){
    return "$bookingId, $jamBooking, $jadwal, $dokter, ";
  }

  @override
  List<Object?> get props => [
    bookingId, jamBooking, jadwal, dokter, ];

}

class Dokter extends Equatable {
  Dokter({
    required this.nama,
    required this.spesialis,
  });

  final String nama;
  final String spesialis;

  factory Dokter.fromJson(Map<String, dynamic> json){
    return Dokter(
      nama: json["nama"] ?? "",
      spesialis: json["spesialis"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "spesialis": spesialis,
  };

  @override
  String toString(){
    return "$nama, $spesialis, ";
  }

  @override
  List<Object?> get props => [
    nama, spesialis, ];

}

class Jadwal extends Equatable {
  Jadwal({
    required this.tanggal,
  });

  final DateTime? tanggal;

  factory Jadwal.fromJson(Map<String, dynamic> json){
    return Jadwal(
      tanggal: DateTime.tryParse(json["tanggal"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "tanggal": tanggal?.toIso8601String(),
  };

  @override
  String toString(){
    return "$tanggal, ";
  }

  @override
  List<Object?> get props => [
    tanggal, ];

}
