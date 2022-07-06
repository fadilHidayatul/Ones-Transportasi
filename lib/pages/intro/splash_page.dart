// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/dashboard_page.dart';
import 'package:transportation/pages/intro/login_page.dart';
import 'package:transportation/providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool firstTimeLogin = true;
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences sp = await SharedPreferences.getInstance();
    firstTimeLogin = sp.getBool('firsttimelogin') ?? true;

    if (firstTimeLogin) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      prov.checkTokenUserIsValid().then((value) {
        if (value == true) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => DashboardPage(),
            ),
          );
        } else {
          showPopUp("Token Login Expire, Silahkan Login Kembali");
          Timer(
            Duration(seconds: 4),
            () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          );
        }
      }).catchError((onError) {
        showPopUp("onError");
      });
    }
  }

  void showPopUp(String msg) {
    AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.NO_HEADER,
      autoHide: Duration(seconds: 3),
      title: 'Warning',
      desc: msg,
      descTextStyle: TextStyle(fontSize: 16),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Image.asset(
                  "assets/images/ic_splash.png",
                  height: 250,
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Lottie.asset("assets/lottie/ic_loading.json",
                        height: 100, width: 100),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
