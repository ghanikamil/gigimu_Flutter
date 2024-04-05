import 'dart:convert';

import 'package:gigimu/data/datasource/api/gigimuAPI.dart';
import 'package:gigimu/data/models/addBookingRequestModel.dart';
import 'package:gigimu/data/models/loginModel.dart';
import 'package:gigimu/data/models/loginResponseModel.dart';
import 'package:dartz/dartz.dart';
import 'package:gigimu/data/models/myBookModel.dart';
import 'package:gigimu/data/models/registerModel.dart';
import 'package:gigimu/data/models/userModel.dart';
import 'package:gigimu/domain/failures/failures.dart';

import '../models/dokterModel.dart';
import '../models/jadwalModel.dart';

class PasienRepo{
  final ApiDatasource apiDatasource = ApiDatasourceImpl();



  Future<Either<Failure, LoginResponseModel>> postLogin(LoginModel loginModel) async{
    try{
      final result = await apiDatasource.postLogin(loginModel);
      return right(result);
    }catch(error){
      return left(GeneralFailure());
    }
  }


  Future<UserModel> getUserDataById(String userId) async{
    try{
      final result = await apiDatasource.getUserById(userId);
      return result;
    }catch(error){
      throw ArgumentError(error);
    }
  }

  Future<List<DokterModel>> getDokters() async{
    final jsonArray = jsonDecode(await apiDatasource.getDokters());
    var listDokter = <DokterModel>[];
    for(var i = 0; i< jsonArray.length;i++){
      var dokter = DokterModel.fromJson(jsonArray[i]);
      listDokter.add(dokter);
    }
    return listDokter;
  }

  Future<List<MyBookModel>> getMyBook(String userId) async{
    final jsonArray = jsonDecode(await apiDatasource.getMyBook(userId));
    var listBooks = <MyBookModel>[];
    for(var i = 0; i< jsonArray.length;i++){
      var booking = MyBookModel.fromJson(jsonArray[i]);
      listBooks.add(booking);
    }
    return listBooks;
  }

  Future<List<JadwalModel>> getJadwal(String dokterID) async{
    final jsonArray = jsonDecode(await apiDatasource.getJadwalByDokter(dokterID));
    var listJadwals = <JadwalModel>[];
    for(var i = 0; i< jsonArray.length;i++){
      var jadwal = JadwalModel.fromJson(jsonArray[i]);
      listJadwals.add(jadwal);
    }
    return listJadwals;
  }

  Future<void> addBooking(AddBookingRequestModel addBookingRequestModel) async{
    try{
      await apiDatasource.addBooking(addBookingRequestModel);
    }catch(error){
      throw ArgumentError(error);
    }
  }

  Future<void> deleteBooking(String bookingId) async{
    try{
      await apiDatasource.deleteBooking(bookingId);
    }catch(error){
      throw ArgumentError(error);
    }
  }

  Future<void> registerPasien(RegisterModel registerModel) async{
    try{
      await apiDatasource.registerPasien(registerModel);
    }catch(error){
      throw ArgumentError(error);
    }
  }

}