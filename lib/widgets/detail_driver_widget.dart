// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailDriver extends StatelessWidget {
  const DetailDriver({Key? key}) : super(key: key);

  //var penerima data dari constructor disini

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            //puller
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.xmark)),
            ),

            //data diri
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      "assets/images/drv.jpg",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Nama Pengemudi",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "08123456789",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            //detail teks
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Terdaftar di",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Nama Vendornya Contoh Bank Central Asia Raya Percasi",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Model Truk",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Biasanya Truk Atau Fuso",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Plat Nomor",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "BM 12345 ABC",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
