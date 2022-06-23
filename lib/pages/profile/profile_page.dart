// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transportation/pages/profile/edit_profile_page.dart';
import 'package:transportation/pages/profile/tambah_alamat_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).padding.top, 0, 0),
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Profil Pengguna",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )),
      ),
      body: ListView(
        controller: _controller,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: [
          //profile
          Container(
            margin: EdgeInsets.symmetric(vertical: 45),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    "assets/images/clt.jpg",
                    fit: BoxFit.cover,
                    width: 75,
                    height: 75,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Nama Pengguna Bin Nama Pemakai",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),

          //akun saya
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return EditProfilePage();
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 15, top: 30),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Color(0xffF1C351),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Akun Saya",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 15)
                ],
              ),
            ),
          ),

          //tambah alamat
          GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return TambahAlamatPage();
              },));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Color(0xff8451F1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(CupertinoIcons.house_alt, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      "Tambah Alamat Tujuan",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 15)
                ],
              ),
            ),
          ),

          //logout
          GestureDetector(
            onTap: () {
              print("logout");
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Color(0xffF15151),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.power_settings_new_rounded,color: Colors.white,),
                  ),
                  Expanded(
                    child: Text(
                      "Keluar Aplikasi",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,size: 15)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
