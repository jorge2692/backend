import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto/src/api/environment.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/utils/shared_pref.dart';

class AddressProvider {

  final String _url = Environment.API_TESIS;
  final String _api = '/api/address';

  BuildContext? context;
  User? sessionUser;

  Future<void> init(BuildContext context, User? sessionUser)async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Address>> getAll() async{
    try {

      Uri url = Uri.parse(_url + '$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      final data = json.decode(res.body);
      Address address = Address.fromJsonList(data);
      return address.toList;


    }catch(e){
      print('Error GetAll Address: $e');
      return[];

    }


  }


  Future<ResponseApi?> create(Address address) async {

    try{

      Uri url = Uri.parse(_url+ '$_api/create');
      String bodyParams = json.encode(address);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi =  ResponseApi.fromJson(data);
      return responseApi;

    }
    catch(e){
      print('Error: $e');
      return null;
    }
  }

  Future<List<Address>> findByBuild(String idCiudad) async{
    try {

      Uri url = Uri.parse(_url+ '$_api/findByCity/$idCiudad');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      var data = json.decode(res.body);
      Iterable i = data;
      List<Address> direccion = i.map((e) => Address.fromJson(e)).toList();
      return direccion;
    }catch(e){
      print('Error: $e');
      return[];
    }


  }




}