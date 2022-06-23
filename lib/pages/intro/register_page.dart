// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isobscure = true;

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
                      "Daftarkan akun \nanda",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Nama Pengguna",
                      prefixIcon: Icon(
                        CupertinoIcons.person,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "No HP",
                      prefixIcon: Icon(
                        CupertinoIcons.phone,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
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
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    keyboardType: TextInputType.visiblePassword,
                    maxLines: 1,
                    obscureText: isobscure,
                    textInputAction: TextInputAction.done,
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
                ],
              ),
            ),
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2BB7A),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
}
