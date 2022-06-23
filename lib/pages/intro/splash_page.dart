// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transportation/pages/intro/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    check();
  }

  void check() {
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) {
                //check data disini nanti
                return LoginPage();
              },
            )));
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
