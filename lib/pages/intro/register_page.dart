// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transportation/providers/auth_provider.dart';
import 'package:transportation/utils/validate.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isobscure = true;
  bool isobscure2 = true;
  bool loadingConfirm = false;

  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerRePass = TextEditingController();

  Future<void> showPopUp(String title, String msg) async {
    AwesomeDialog(
            context: context,
            animType: AnimType.BOTTOMSLIDE,
            dialogType: DialogType.NO_HEADER,
            autoHide: Duration(seconds: 4),
            title: title,
            desc: msg,
            descTextStyle: TextStyle(fontSize: 16))
        .show();
  }

  void apiRegister(AuthProvider prov) {
    prov
        .doRegister(
      controllerNama.text,
      controllerUsername.text,
      controllerPhone.text,
      controllerEmail.text,
      controllerPassword.text,
      controllerRePass.text,
    )
        .then((value) {
      if (!mounted) return;
      setState(() => loadingConfirm = false);

      showPopUp("Success", "Berhasil melakukan register, silahkan login!");

      Timer(Duration(seconds: 4), () => Navigator.pop(context));
    }).catchError((onError) {
      if (!mounted) return;
      setState(() => loadingConfirm = false);

      showPopUp("Warning", "$onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 36, 24, 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 36),
                      child: Text(
                        "Daftarkan akun \nanda",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: controllerNama,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                      ],
                      decoration: InputDecoration(
                        hintText: "Nama",
                        prefixIcon: Icon(
                          CupertinoIcons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: controllerUsername,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z.,_@-]"))
                      ],
                      decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: Icon(
                          CupertinoIcons.person_circle,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: controllerPhone,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9+]"))
                      ],
                      decoration: InputDecoration(
                        hintText: "No HP",
                        prefixIcon: Icon(
                          CupertinoIcons.phone,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
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
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: controllerPassword,
                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      obscureText: isobscure,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (!mounted) return;
                            setState(() => isobscure = !isobscure);
                          },
                          icon: Icon(
                            isobscure
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: controllerRePass,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      obscureText: isobscure2,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "Konfirmasi Password",
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (!mounted) return;
                            setState(() => isobscure2 = !isobscure2);
                          },
                          icon: Icon(
                            isobscure2
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Column(
              children: [
                loadingConfirm
                    ? CupertinoActivityIndicator(
                        color: Color(0xFFEBA146),
                        radius: 14,
                      )
                    : InkWell(
                        onTap: () {
                          if (controllerNama.text.isEmpty ||
                              controllerUsername.text.isEmpty ||
                              controllerPhone.text.isEmpty ||
                              controllerEmail.text.isEmpty ||
                              controllerPassword.text.isEmpty ||
                              controllerRePass.text.isEmpty) {
                            showPopUp("Warning", "Semua field harus diisi");
                          } else if (ValidatePhone()
                                  .isValidPhone(controllerPhone.text) ==
                              false) {
                            showPopUp("Warning", "Masukkan No HP yang valid");
                          } else if (ValidateEmail()
                                  .isValidEmail(controllerEmail.text) ==
                              false) {
                            showPopUp("Warning", "Masukkan email yang benar");
                          } else if (LengthPassword()
                                  .minChar(controllerPassword.text) ==
                              false) {
                            showPopUp("Warning", "Password minimal 6 karakter");
                          } else if (controllerPassword.text !=
                              controllerRePass.text) {
                            showPopUp(
                                "Warning", "Harap Masukkan Password yang sama");
                          } else {
                            setState(() {
                              loadingConfirm = true;
                            });

                            apiRegister(prov);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                              color: Color(0xFFF2BB7A),
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun? Silahkan "),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "login",
                        style: TextStyle(color: Color(0xFFF2BB7A)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controllerNama.dispose();
    controllerUsername.dispose();
    controllerPhone.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerRePass.dispose();
    super.dispose();
  }
}
