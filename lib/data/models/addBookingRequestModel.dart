import 'package:equatable/equatable.dart';

class AddBookingRequestModel extends Equatable {
  AddBookingRequestModel({
    required this.pasienId,
    required this.jadwalDokterId,
    required this.jamBooking,
  });

  final int pasienId;
  final int jadwalDokterId;
  final DateTime? jamBooking;

  factory AddBookingRequestModel.fromJson(Map<String, dynamic> json){
    return AddBookingRequestModel(
      pasienId: json["pasienID"] ?? 0,
      jadwalDokterId: json["jadwalDokterID"] ?? 0,
      jamBooking: DateTime.tryParse(json["jamBooking"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "pasienID": pasienId,
    "jadwalDokterID": jadwalDokterId,
    "jamBooking": jamBooking?.toIso8601String(),
  };

  @override
  String toString(){
    return "$pasienId, $jadwalDokterId, $jamBooking, ";
  }

  @override
  List<Object?> get props => [
    pasienId, jadwalDokterId, jamBooking, ];

}
