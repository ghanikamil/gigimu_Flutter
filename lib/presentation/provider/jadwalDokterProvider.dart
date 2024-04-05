import 'package:flutter/cupertino.dart';
import 'package:gigimu/data/models/jadwalModel.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';

class JadwalDokterProvider extends ChangeNotifier{
  var listJadwal = <JadwalModel>[];

  void getJadwals (String dokterID) async{
    listJadwal = await PasienUseCases().getJadwal(dokterID);
    notifyListeners();
  }
}
