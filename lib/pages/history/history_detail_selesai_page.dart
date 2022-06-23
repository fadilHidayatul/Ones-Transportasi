// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transportation/widgets/detail_driver_widget.dart';

class HistoryDetailSelesaiPage extends StatefulWidget {
  const HistoryDetailSelesaiPage({Key? key}) : super(key: key);

  @override
  State<HistoryDetailSelesaiPage> createState() =>
      _HistoryDetailSelesaiPageState();
}

class _HistoryDetailSelesaiPageState extends State<HistoryDetailSelesaiPage> {
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
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Detail Order",
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
        controller: _controller,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 14),
        children: [
          //bagian pengemudi
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                  builder: (context) => DetailDriver());
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Nama Pengemudi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Jenis Truk",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFAD066),
                              borderRadius: BorderRadius.circular(6)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Text("BA 1 M",style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(72),
                  child: Image.asset(
                    "assets/images/drv.jpg",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.black12,
            ),
          ),

          //bagian biaya
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12, top: 6),
                child: Text(
                  "Biaya Perjalanan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              //kemungkinan bisa banyak row kalo banyak detail pembayaran
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Uang Jalan",
                    style: TextStyle(fontSize: 16),
                  ),
                  //pake format uang nanti
                  Text("Rp. 500.000")
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Divider(
                  color: Colors.black12,
                  height: 1,
                  thickness: 1,
                ),
              ),
            ],
          ),

          //bagian ID perjalanan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                "ID Perjalanan : XXXXX",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              //pake format tgl
              Text(
                "00-00-0000",
                style: TextStyle(fontSize: 16,color: Colors.grey.shade500),
              )
            ],
          ),
          SizedBox(height: 30),

          //bagian lokasi berangkat
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Color(0xffFF8A00),
                size: 26,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Lokasi Berangkat",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("Jalan By Pass KM 07 Padang"),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 22),

          //bagian tempat tujuan
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                CupertinoIcons.location_circle,
                color: Color(0xff8451F1),
                size: 24,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Lokasi Tujuan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                        "Jalan X No 19 Pulau Punjung Dharmasraya"),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
