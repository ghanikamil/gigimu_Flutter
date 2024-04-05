import 'dart:convert';

import 'package:gigimu/data/models/addBookingRequestModel.dart';
import 'package:gigimu/data/models/loginModel.dart';
import 'package:gigimu/data/models/loginResponseModel.dart';
import 'package:gigimu/data/models/registerModel.dart';
import 'package:gigimu/data/models/userModel.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../models/myBookModel.dart';

abstract class ApiDatasource{
  Future<LoginResponseModel> postLogin(LoginModel loginModel);
  Future<UserModel> getUserById(String userId);
  Future<String> getDokters();
  Future<String> getMyBook(String userId);
  Future<String> getJadwalByDokter(String dokterID);
  Future<void> addBooking(AddBookingRequestModel addBookingRequestModel);
  Future<void> deleteBooking(String bookingId);
  Future<void> registerPasien(RegisterModel registerModel);
}
class ApiDatasourceImpl implements ApiDatasource{
  final String Url = "https://app.actualsolusi.com/bsi/gigimu/api/Pasiens";
  final client = http.Client();
  var box = Hive.box("userData");

  @override
  Future<LoginResponseModel> postLogin(LoginModel loginModel) async {
    // TODO: implement postLogin
    final response = await client.post(
      Uri.parse(Url+"/Login"),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(loginModel.toJson())
    );

    try{
      if (response.statusCode != 200){
        print("server error: ${response.body}");
        throw ArgumentError('Error status code tidak 200');
      } else{

        final dynamic responseBody = json.decode(response.body);
        LoginResponseModel responseData = LoginResponseModel.fromJson(responseBody as Map<String,dynamic>);
        return responseData;
      }
    }catch(error){
      throw ArgumentError('Error: ${error}');
    }
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    // TODO: implement getUserById
    //print(id);
    final response = await client.get(
      Uri.parse("${Url}/GetProfilePasien/${userId}"),
      headers:<String,String> {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.get('token')}'
      }
    );
    try{
      if(response.statusCode!=200){
        print("server error: ${response.body}");
        throw ArgumentError('Error status code tidak 200');
      }
      else{
        final dynamic responseBody = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(responseBody as Map<String,dynamic>);
        return user;
      }
    }catch(error){
      throw ArgumentError('Error: ${error}');
    }
  }

  @override
  Future<String> getDokters() async{
    // TODO: implement getDokters
    var response = await http.get(
      Uri.parse("${Url}/GetAllDokter"),
        headers:<String,String> {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        }
    );
    return response.body;
  }

  @override
  Future<String> getMyBook(String userId) async {
    // TODO: implement getMyBook
    var response = await http.get(
        Uri.parse("${Url}/GetAllMyBook/${userId}"),
        headers:<String,String> {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        }
    );
    return response.body;
  }

  @override
  Future<String> getJadwalByDokter(String dokterID) async{
    // TODO: implement getJadwalByDokter
    var response = await http.get(
        Uri.parse("${Url}/GetJadwalByDokter/${dokterID}"),
        headers:<String,String> {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        }
    );
    return response.body;
  }

  @override
  Future<void> addBooking(AddBookingRequestModel addBookingRequestModel) async{
    // TODO: implement addBooking
    await client.post(
        Uri.parse("${Url}/AddBooking"),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: jsonEncode(addBookingRequestModel.toJson())
    );
  }

  @override
  Future<void> deleteBooking(String bookingId) async {
    // TODO: implement deleteBooking
    await client.delete(
        Uri.parse("${Url}/DeleteBooking/${bookingId}"),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
    );
  }

  @override
  Future<void> registerPasien(RegisterModel registerModel) async {
    // TODO: implement registerPasien
    await client.post(
        Uri.parse("${Url}/Register"),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: jsonEncode(registerModel.toJson())
    );
  }
}