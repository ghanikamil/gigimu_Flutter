import 'package:flutter/cupertino.dart';
import 'package:gigimu/data/models/dokterModel.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';

class ListDokterProvider extends ChangeNotifier{
  var listDokter = <DokterModel>[];

  void getDokters () async{
    listDokter = await PasienUseCases().getDokters();
    notifyListeners();
  }
}
