import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto/src/api/environment.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/utils/shared_pref.dart';

class CategoriesProvider {

  String _url = Environment.API_TESIS;
  String _api = '/api/categories';

  BuildContext? context;
  User? sessionUser;

  Future? init(BuildContext context, User? sessionUser){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Category>> getAll() async{
    try {

      Uri url = Uri.http(_url, '$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context!, sessionUser!.id!);
      }

      final data = json.decode(res.body);
      print(data);
      Category category = Category.fromJsonList(data);
      return category.toList;


    }catch(e){
      print('Error CategoriesProvider: $e');
      return[];

    }


  }


  Future<ResponseApi?> create(Category category) async {

    try{

      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context!, sessionUser!.id!);
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
}