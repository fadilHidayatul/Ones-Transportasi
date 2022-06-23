// ignore_for_file: prefer_const_constructors, prefer_collection_literals

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:transportation/utils/counting_distance.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String>? listTempat = [
    "-0.9524403,100.3608588",
    "-0.9360865,100.3587197",
    "-0.9356128,100.3558675",
    "-0.929340,100.358010",
    "-1.0036799,100.3645023",
  ];
  List<String>? listTruk = [
    "Nama truk beserta dengan supir",
    "Nama truk beserta dengan supir pribadi keren",
    "Nama truk supir ",
    "Nama truk yang dibawa oleh supir sejauh mata memandang mafakenyah",
    "truk"
  ];
  double latStart = 0;
  double lngStart = 0;
  double latEnd = 0;
  double lngEnd = 0;
  double distance = 0;
  String selectedTruck = "";
  var location = Location();

  GoogleMapController? _mapController;
  Set<Marker> markers = {};

  BitmapDescriptor sourceIc = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIc = BitmapDescriptor.defaultMarker;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void assetMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(24, 24)),
      "assets/images/source_icon.png",
    ).then((value) => sourceIc = value);

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(24, 24)),
      "assets/images/destination_icon.png",
    ).then((value) {
      destinationIc = value;
    });
  }

  Future<void> getLocUser() async {
    try {
      location.getLocation().then((value) {
        if (!mounted) return;
        setState(() {
          latStart = value.latitude!;
          lngStart = value.longitude!;

          addMarker(MarkerId('lokasi_saya'), latStart, lngStart, sourceIc,
              "lokasi awal");
        });

        getFirstDestinationUser();
      });
    } catch (e) {
      print("error get location : $e");
    }
  }

  void getFirstDestinationUser() {
    //ini nanti untuk get API, list tempat pertama langsung di set ke marker
    latEnd = double.parse(listTempat![0].split(',').first);
    lngEnd = double.parse(listTempat![0].split(',').last);

    if (!mounted) return;
    setState(() {
      addMarker(MarkerId('lokasi_tujuan'), latEnd, lngEnd, destinationIc,
          "lokasi tujuan");

      distance = DistanceLatLng()
          .calculateDistance(latStart, lngStart, latEnd, lngEnd);
    });
  }

  void addMarker(MarkerId id, double lat, double lng, BitmapDescriptor icon,
      String snippet) {
    markers.add(
      Marker(
        markerId: id,
        position: LatLng(lat, lng),
        icon: icon,
        infoWindow: InfoWindow(snippet: snippet),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    markers.clear;
    assetMarker();
    getLocUser();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
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
              "Order Transportasi",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          //bagian pilih tempat
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
            width: double.infinity,
            child: Text(
              "Pilih Lokasi Tujuan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            color: Color(0xFFFAF9F8),
            margin: EdgeInsets.symmetric(vertical: 12),
            elevation: 0.4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    color: Color(0xffFF8A00),
                  ),
                  SizedBox(width: 5),
                  Expanded(child: Text("Lokasi Anda Sekarang"))
                ],
              ),
            ),
          ),

          //lokasi tujuan
          Card(
            color: Color(0xFFFAF9F8),
            elevation: 0.4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.zero,
            child: DropdownSearch<String>(
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                showSelectedItems: true,
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "List Lokasi Tujuan",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                bottomSheetProps: BottomSheetProps(
                  enableDrag: true,
                  backgroundColor: Color(0xFFF0EEEB),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              dropdownButtonProps: DropdownButtonProps(
                icon: Icon(Icons.abc),
                iconSize: 0,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.location_circle,
                    color: Color(0xff8451F1),
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              items: listTempat!,
              selectedItem:
                  listTempat![0], // ambil dari respone berupa nama tempat
              onChanged: (tempat) {
                if (!mounted) return;
                setState(() {
                  MarkerId id = MarkerId('lokasi_tujuan');
                  //ambil yang dari respon berupa lat long
                  latEnd = double.parse(tempat.toString().split(',').first);
                  lngEnd = double.parse(tempat.toString().split(',').last);

                  if (latEnd != 0 && lngEnd != 0) {
                    if (markers.length > 1) {
                      //logika here
                      markers.removeWhere((element) =>
                          element.markerId.value == 'lokasi_tujuan');

                      // for (var element in markers) {
                      //   print("marker1 : ${element.position}");
                      // }
                    } else {
                      // print("marker2 : ${markers.length}");
                    }

                    addMarker(
                        id, latEnd, lngEnd, destinationIc, "lokasi tujuan");

                    distance = DistanceLatLng()
                        .calculateDistance(latStart, lngStart, latEnd, lngEnd);
                  }
                });
              },
            ),
          ),

          //bagian pilih truk
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
            width: double.infinity,
            child: Text(
              "List Truk Tersedia",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            color: Color(0xFFFAF9F8),
            elevation: 0.4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.zero,
            child: DropdownSearch<String>(
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                showSelectedItems: true,
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "List Truk",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                bottomSheetProps: BottomSheetProps(
                  enableDrag: true,
                  backgroundColor: Color(0xFFF0EEEB),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              dropdownButtonProps: DropdownButtonProps(
                icon: Icon(Icons.abc),
                iconSize: 0,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.directions_bus_outlined,
                      color: Color(0xffF15151),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
              items: listTruk!,
              selectedItem: listTruk![0], //pengecekan list truk dg ini ??
              onChanged: (truk) {
                if (!mounted) return;
                setState(() {
                  selectedTruck = truk.toString();
                });
              },
            ),
          ),

          //bagian tampil map
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
            width: double.infinity,
            child: Text(
              "Map Lokasi Tujuan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          //kalo udah ada API cek ini dengan laatend==null
          latEnd == 0 || lngEnd == 0 || latStart == 0 || lngStart == 0
              ? Offstage()
              : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              latStart,
                              lngStart,
                            ),
                            zoom: 12,
                          ),
                          markers: markers,
                          gestureRecognizers: Set()
                            ..add(
                              Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                              ),
                            ),
                        ),
                      ),
                    ),

                    //keterangan dari map
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/source_icon.png",
                                width: 20,
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text("Lokasi berangkat"),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/destination_icon.png",
                                width: 20,
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text("Lokasi tujuan"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.ramp_left_outlined,
                            color: Color(0xffF15151),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Jarak tempuh : ${distance.toStringAsFixed(2)} KM",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

          //button bawah
          SizedBox(height: 150),
          GestureDetector(
            onTap: () {
              print("truk : $selectedTruck");
              print("tempat : $latEnd - $lngEnd");
              print("userloc center: $latStart  _  $lngStart");
            },
            child: Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: Color(0xFFF2BB7A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                  child: Text(
                "Lanjutkan Pesanan",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
