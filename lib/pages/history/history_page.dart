// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transportation/pages/history/history_detail_selesai_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int segment = 0;

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
              "History Order",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )),
      ),
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CupertinoSlidingSegmentedControl(
                    children: {
                      0: Text(
                        "Aktif",
                        style: TextStyle(
                          color: (segment == 0) ? Colors.white : Colors.black,
                        ),
                      ),
                      1: Text(
                        "Selesai",
                        style: TextStyle(
                          color: (segment == 1) ? Colors.white : Colors.black,
                        ),
                      )
                    },
                    onValueChanged: (pilihan) {
                      setState(() => segment = pilihan as int);
                    },
                    groupValue: segment,
                    thumbColor: Color(0xFFF2BB7A),
                    backgroundColor: Color(0xFFFAF9F9),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: segment == 0
                  ? ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color(0xffFAF4EE),
                          margin: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0.2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(18, 4, 18, 4),
                                    margin: EdgeInsets.fromLTRB(0, 12, 12, 0),
                                    child: Text(
                                      "Aktif",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFB800),
                                        borderRadius: BorderRadius.circular(8)),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      height: 120,
                                      margin: EdgeInsets.fromLTRB(12, 0, 12, 4),
                                      child: Image.asset(
                                          "assets/images/ic_splash.png"),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(
                                                  Icons.directions_bus_outlined,
                                                  color: Color(0xFFF59D31),
                                                  size: 20,
                                                ),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    "Nama Truk paling sepanjang ini",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              children: const [
                                                Icon(
                                                  Icons.car_repair_outlined,
                                                  color: Color(0xFFF59D31),
                                                  size: 23,
                                                ),
                                                SizedBox(width: 3),
                                                Expanded(
                                                  child: Text(
                                                    "Tipe truk kalo ada API nya",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              children: const [
                                                Icon(
                                                  CupertinoIcons.location,
                                                  color: Color(0xFFF59D31),
                                                  size: 20,
                                                ),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    "Tujuan nya belum atau entah dari API atau dari LatLng",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: 12,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            //nanti dikirim model berdasarkan index
                            Navigator.push(context, CupertinoPageRoute(
                              builder: (context) {
                                return HistoryDetailSelesaiPage();
                              },
                            ));
                          },
                          child: Card(
                            color: Color(0xFFFCF8F5),
                            margin: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0.2,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(18, 4, 18, 4),
                                      margin: EdgeInsets.fromLTRB(0, 12, 12, 0),
                                      child: Text(
                                        "Selesai",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF18D100),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    //untuk gambar
                                    Flexible(
                                      flex: 2,
                                      child: Container(
                                        width: double.infinity,
                                        height: 120,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        margin:
                                            EdgeInsets.fromLTRB(12, 0, 12, 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Image.asset(
                                          "assets/images/truk1.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    //untuk keterangan teks
                                    Expanded(
                                        flex: 3,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons
                                                        .directions_bus_outlined,
                                                    color: Color(0xFFF59D31),
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      "Hino Truk",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.car_repair_outlined,
                                                    color: Color(0xFFF59D31),
                                                    size: 23,
                                                  ),
                                                  SizedBox(width: 3),
                                                  Expanded(
                                                    child: Text(
                                                      "Tronton roda 6",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    CupertinoIcons.location,
                                                    color: Color(0xFFF59D31),
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      "Padang -Dharmasraya",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )),
        ],
      ),
    );
  }
}
