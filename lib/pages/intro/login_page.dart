// ignore_for_file: prefer_const_constructors

import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_address/mac_address.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:transportation/dashboard_page.dart';
import 'package:transportation/pages/intro/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;

  String? platformVersion;
  String? deviceID;
  String? imei;

  Future<void> cekPermission() async {
    final PermissionStatus permission = await Permission.phone.status;
    try {
      if (permission == PermissionStatus.denied ||
          permission == PermissionStatus.restricted) {
        _getPhonePermission();
      } else if (permission == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        getDetailDevice();
      }
    } catch (e) {
      print("failed info : $e");
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
    platformVersion = await GetMac.macAddress;
    deviceID = await PlatformDeviceId.getDeviceId;
    imei = await DeviceInformation.deviceIMEINumber;

    print("info mac : $platformVersion");
    print("info devId : $deviceID");
    print("info imei : $imei");
  }

  @override
  void initState() {
    super.initState();

    cekPermission();
  }

  @override
  Widget build(BuildContext context) {
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
                    TextField(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    TextField(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    InkWell(
                      onTap: () {
                        //pengecekan akun login disini
                        Navigator.pushReplacement(context, CupertinoPageRoute(
                          builder: (context) {
                            return DashboardPage();
                          },
                        ));
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
