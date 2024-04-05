import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:gigimu/data/models/addBookingRequestModel.dart';
import 'package:gigimu/data/models/loginModel.dart';
import 'package:gigimu/data/models/myBookModel.dart';
import 'package:gigimu/data/models/registerModel.dart';
import 'package:gigimu/data/models/userModel.dart';
import 'package:gigimu/data/repositories/pasienRepo.dart';
import 'package:gigimu/domain/failures/failures.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../data/models/dokterModel.dart';
import '../../data/models/jadwalModel.dart';

class PasienUseCases{
  final pasienRepo = PasienRepo();

  Future<bool> postUserLoginData({required LoginModel loginModel }) async{
    bool succes = false;
    var box = Hive.box('userData');
    var result = await pasienRepo.postLogin(loginModel);
    result.fold(
            (failure) {
              succes = false;
            },
            (user) {
              DateTime currentTime = DateTime.now();
              DateTime futureTime = currentTime.add(const Duration(hours: 1));
              Map<String,dynamic> decodedToken = JwtDecoder.decode(user.token);

              box.put('id', decodedToken['nameid']);
              box.put('nama', user.name);
              box.put('email', user.email);
              box.put('token', user.token);
              box.put('session_timeout', futureTime.toString());
              succes = true;
            }
    );
    return succes;
  }

  Future<UserModel> getUserDataById(String userId) async {

    return await pasienRepo.getUserDataById(userId);
  }

  Future<List<DokterModel>> getDokters() async{
    return await pasienRepo.getDokters();
  }

  Future<bool> postUserLogout() async{
    bool succes = false;
    var box = Hive.box('userData');
    box.put('id', null);
    box.put('nama', null);
    box.put('email', null);
    box.put('token', null);
    box.put('session_timeout', null);
    succes = true;
    return succes;
  }

  Future<List<MyBookModel>> getMyBook(String userId) async {
    return await pasienRepo.getMyBook(userId);
  }

  Future<List<JadwalModel>> getJadwal(String dokterID) async{
    return await pasienRepo.getJadwal(dokterID);
  }

  Future<bool> addBooking(AddBookingRequestModel addBookingRequestModel) async{
    bool succes = true;
    await pasienRepo.addBooking(addBookingRequestModel);
    return succes;
  }

  Future<bool> deleteBooking(String bookingId) async{
    bool succes = true;
    await pasienRepo.deleteBooking(bookingId);
    return succes;
  }

  Future<bool> registerPasien(RegisterModel registerModel) async{
    bool succes = true;
    await pasienRepo.registerPasien(registerModel);
    return succes;
  }

}