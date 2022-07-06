import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/main.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String urlLogin = "${MyApp.domain}member/login";
  String urlRegister = "${MyApp.domain}member/register";
  String authcheck = "${MyApp.domain}member/profile";

  Future<void> doLogin(
    String email,
    String pass,
    String mac,
    String deviceID,
    String imei,
  ) async {
    Uri url = Uri.parse(urlLogin);

    try {
      Map<String, String> body = {
        "email": email,
        "password": pass,
        "device_id": deviceID,
        "mac": mac,
        "imei": imei,
      };

      var response = await http.post(url, body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var decodeData = json.decode(response.body);

        if (decodeData["success"] == true) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.clear();
          sp.setString('logintoken', decodeData["data"]["access_token"]);
          sp.setBool('firsttimelogin', false);

          print("$deviceID - $mac - $imei");

          notifyListeners();
        } else {
          throw ("Harap periksa email dan password yang benar");
        }
      } else {
        throw (json.decode(response.body)["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkTokenUserIsValid() async {
    Uri url = Uri.parse(authcheck);

    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('logintoken') ?? "";

    try {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var response = await http.get(url, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var decodeData = json.decode(response.body);
        if (decodeData["success"] == true) {
          //move to dashboard
          notifyListeners();
          return true;
        } else {
          notifyListeners();
          return false;
        }
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> doRegister(
    String name,
    String username,
    String phone,
    String email,
    String password1,
    String password2,
  ) async {
    Uri url = Uri.parse(urlRegister);
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');

    try {
      Map<String, dynamic> body = {
        "name": name,
        "username": username,
        "email": email,
        "password": password1,
        "password_confirmation": password2,
        "handphone": phone,
        "description": "temp",
        "image": "null",
        "birthday": formatter.format(now).toString(),
        "gender": "temp",
        "status": "1",
        "flag": "1",
        "secret": "temp_imei",
        "device_id": "temp_devid",
        "mac": "temp_mac"
      };

      var response = await http.post(url, body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var decodeData = json.decode(response.body);

        if (decodeData["success"] == true) {
          //success

          notifyListeners();
        } else {
          throw ("not success : $decodeData");
        }
      } else {
        throw ("response : ${json.decode(response.body)}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
