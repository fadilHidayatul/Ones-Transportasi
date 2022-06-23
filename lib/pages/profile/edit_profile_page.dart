// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _controllerNama;
  late TextEditingController _controllerHP;
  late TextEditingController _controllerEmail;

  final ScrollController _con = ScrollController();

  @override
  void didChangeDependencies() {
    _controllerNama = TextEditingController(text: "karina");
    _controllerHP = TextEditingController(text: "08226666172");
    _controllerEmail = TextEditingController(text: "karina@example.id");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _con.dispose();
    _controllerNama.dispose();
    _controllerHP.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Edit Profil",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(CupertinoIcons.back)),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        controller: _con,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: [
          //bagian pp
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 20),
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.asset(
                "assets/images/clt.jpg",
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
          ),

          //form nama
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _controllerNama,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                maxLines: 1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20)),
              )
            ],
          ),

          SizedBox(height: 15),

          //form hp
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "No HP",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _controllerHP,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                maxLines: 1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20)),
              )
            ],
          ),

          SizedBox(height: 15),

          //form email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "E-mail",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _controllerEmail,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                maxLines: 1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20)),
              )
            ],
          ),

          SizedBox(height: 60),

          //button confirm
          InkWell(
            onTap: () {
              print("update data");
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xFFF2BB7A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "Simpan Data",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
