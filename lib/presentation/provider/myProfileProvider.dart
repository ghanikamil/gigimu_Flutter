import 'package:flutter/cupertino.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';
import 'package:hive/hive.dart';

import '../../data/models/userModel.dart';

class MyProfileProvider extends ChangeNotifier{
  UserModel? myProfile;
  var box = Hive.box("userData");

  void getProfile () async{
    myProfile = await PasienUseCases().getUserDataById(box.get('id'));
    notifyListeners();
  }
}