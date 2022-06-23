// ignore_for_file: prefer_const_constructors

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'package:transportation/utils/place_service.dart';
import 'package:transportation/widgets/address_search.dart';
import 'package:uuid/uuid.dart';

class TambahAlamatPage extends StatefulWidget {
  const TambahAlamatPage({Key? key}) : super(key: key);

  @override
  State<TambahAlamatPage> createState() => _TambahAlamatPageState();
}

class _TambahAlamatPageState extends State<TambahAlamatPage> {
  final ScrollController _con = ScrollController();
  final TextEditingController _controllerTempat = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();

  var location = Location();

  String pickedLocation = "Pilih lokasi";
  bool? isAutomaticLoc;
  double? selectedLat;
  double? selectedLng;

  Future<void> getLocationUser() async {
    try {
      location.getLocation().then((value) {
        if (!mounted) return;

        setState(() {
          selectedLat = value.latitude;
          selectedLng = value.longitude;
        });
      });
    } catch (e) {
      print("Error loc : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationUser();
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
                  "Tambah Alamat Tujuan",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _con,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: [
                //nama tempat
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 8),
                      child: Text(
                        "Nama Tempat",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: _controllerTempat,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.bungalow_outlined),
                          contentPadding: EdgeInsets.all(0)),
                    )
                  ],
                ),

                //alamat
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 8),
                      child: Text(
                        "Alamat",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: _controllerAlamat,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.corporate_fare_rounded),
                          contentPadding: EdgeInsets.all(0)),
                    )
                  ],
                ),

                // map
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Pilih titik lokasi",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                //pilih lokasi di map
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isAutomaticLoc = false;
                    });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PlacePicker(
                    //       apiKey: Platform.isAndroid
                    //           ? "AIzaSyDy5rGHGiRVLPaFPSPb5Db3wumRvKxtxsU"
                    //           : "AIzaSyDy5rGHGiRVLPaFPSPb5Db3wumRvKxtxsU",
                    //       initialPosition: LatLng(-0.9524403, 100.3608588),
                    //       onPlacePicked: (pickResult) {
                    //         print("placep : ${pickResult.formattedAddress}");
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //   ),
                    // );
                    // print("placep : ${result?.placeId}");

                    final sessionToken = Uuid().v4();
                    final Suggestion? result = await showSearch(
                      context: context,
                      delegate: AddressSearch(sessionToken),
                    );

                    if (result != null) {
                      setState(() {
                        pickedLocation = result.description;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 18),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xffFF8A00),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.pin_drop_outlined,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pickedLocation,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 15)
                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    "Atau",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                //pilih lokasi sendiri
                GestureDetector(
                  onTap: () {
                    //possibly
                    setState(() {
                      if (selectedLat!=null && selectedLng!=null) {
                        isAutomaticLoc = true;
                      }
                    });
                  },
                  child: Container(
                    decoration: isAutomaticLoc == true
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(width: 1, color: Color(0xffFF8A00)))
                        : BoxDecoration(),
                    padding: EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 18),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Color(0xffFF8A00),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.my_location_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Gunakan Koordinat Lokasi Sekarang",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 15)
                      ],
                    ),
                  ),
                ),
                isAutomaticLoc == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Text(
                          "Note : Sedang menggunakan koordinat lokasi sekarang!!",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )
                    : Offstage(),
              ],
            ),
          ),

          //button confirm
          InkWell(
            onTap: () {
              isAutomaticLoc == null
                  ? print("pilih lokasi atau gunakan koordinat")
                  : isAutomaticLoc == true
                      ? print("koordinat :$selectedLat - $selectedLng")
                      : print("kemungkinan dari place picker");
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(35, 0, 35, 5),
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xFFF2BB7A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "Tambahkan Alamat",
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
