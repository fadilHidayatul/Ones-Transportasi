// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_address/mac_address.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:transportation/dashboard_page.dart';
import 'package:transportation/pages/intro/register_page.dart';
import 'package:transportation/providers/auth_provider.dart';
import 'package:transportation/utils/validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  bool isObscure = true;
  bool loadingConfirm = false;

  String? mac;
  String? deviceID;
  String? imei;

  ///function
  void showPopUp(String msg) {
    AwesomeDialog(
            context: context,
            animType: AnimType.BOTTOMSLIDE,
            dialogType: DialogType.NO_HEADER,
            autoHide: Duration(seconds: 3),
            title: 'Warning',
            desc: msg,
            descTextStyle: TextStyle(fontSize: 16))
        .show();
  }

  Future<void> cekPermission() async {
    final PermissionStatus permission = await Permission.phone.status;
    try {
      if (permission == PermissionStatus.denied ||
          permission == PermissionStatus.restricted) {
        _getPhonePermission();
      } else if (permission == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }else{
        getDetailDevice();
      }
    } catch (e) {
      showPopUp("$e");
    }
  }

  Future<void> _getPhonePermission() async {
    await [Permission.phone].request().then((value) {
      if (value.values.contains((PermissionStatus.granted))) {
        getDetailDevice();
      }
    });
  }

  Future<void> getDetailDevice() async {
    mac = await GetMac.macAddress;
    deviceID = await PlatformDeviceId.getDeviceId;
    imei = await DeviceInformation.deviceIMEINumber;
  }

  void apiLogin(AuthProvider prov){
    prov
        .doLogin(controllerEmail.text, controllerPassword.text, mac!, deviceID!,
            imei!)
        .then((value) {
      if (!mounted) return;
      setState(() => loadingConfirm = false);

      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) {
            return DashboardPage();
          },
        ),
      );
    }).catchError((onError) {
      if (!mounted) return;
      setState(() => loadingConfirm = false);

      showPopUp("Error login : \n$onError");
    });
  }

  @override
  void initState() {
    super.initState();

    cekPermission();
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 36, 24, 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 36),
                      child: Text(
                        "Login ke akun \nanda",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "E-Mail",
                          prefixIcon: Icon(
                            CupertinoIcons.at,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: controllerPassword,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (!mounted) return;
                              setState(() => isObscure = !isObscure);
                            },
                            icon: Icon(
                              isObscure
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              color: Colors.black,
                            )),
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 75),
                    loadingConfirm
                        ? CupertinoActivityIndicator(
                            color: Color(0xFFEBA146),
                            radius: 14,
                          )
                        : InkWell(
                            onTap: () async {
                              //pengecekan akun login disini
                              if (ValidateEmail()
                                      .isValidEmail(controllerEmail.text) ==
                                  false) {
                                showPopUp("Masukkan email yang benar");
                              } else if (LengthPassword()
                                      .minChar(controllerPassword.text) ==
                                  false) {
                                showPopUp("Password minimal 6 karakter");
                              } else {
                                setState(() => loadingConfirm = true);

                                await Permission.phone.status.then((value) {
                                  if (value == PermissionStatus.granted) {
                                    //panggil API
                                    apiLogin(prov);
                                  } else {
                                    if (!mounted) return;
                                    setState(() => loadingConfirm = false);
                                    _getPhonePermission();
                                  }
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: Color(0xFFF2BB7A),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum Punya akun? silahkan "),
                InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) {
                          return RegisterPage();
                        },
                      ));
                    },
                    child: Text(
                      "daftar",
                      style: TextStyle(color: Color(0xFFF2BB7A)),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
