import 'package:flutter/cupertino.dart';
import 'package:gigimu/data/models/myBookModel.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';
import 'package:hive/hive.dart';

class MyBookingProvider extends ChangeNotifier{
  var myBooks = <MyBookModel>[];
  var box = Hive.box("userData");

  void getMyBooks () async{
    myBooks = await PasienUseCases().getMyBook(box.get('id'));
    notifyListeners();
  }
}
