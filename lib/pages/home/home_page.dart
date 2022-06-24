// ignore_for_file: prefer_const_constructors, prefer_collection_literals

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_manager;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? mapController;
  location_manager.LocationData? currentLocation;
  var location = location_manager.Location();
  var center = LatLng(0, 0);
  String uAddress = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

/////////////////////////method/////////////////////

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // getUserLocation();
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: center, zoom: 18),
      ),
    );
    addMarker(center);
    getAddressFromLatLng(center);
  }

  void addMarker(LatLng center) {
    final markerOption = Marker(
      markerId: MarkerId("Lokasi Kamu"),
      position: center,
      icon: BitmapDescriptor.defaultMarker,
    );

    if (mounted) {
      setState(() {
        markers[MarkerId('Lokasi Kamu')] = markerOption;
      });
    }
  }

  Future<void> getUserLocation() async {
    try {
      location.getLocation().then((value) {
        if (!mounted) return;
        setState(() {
          currentLocation = value;
          final lat = currentLocation?.latitude;
          final lng = currentLocation?.longitude;
          center = LatLng(lat!, lng!);

          // print("getlocation jalan");
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddressFromLatLng(LatLng center) async {
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(center.latitude, center.longitude);

      Placemark place1 = placemark[0];

      setState(() {
        uAddress =
            "${place1.thoroughfare} ${place1.subLocality} ${place1.subAdministrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> userChangeLocation() async {
    try {
      location.changeSettings(interval: 120000);
      location.onLocationChanged.listen((event) {
        if (!mounted) return;
        setState(() {
          center = LatLng(event.latitude!, event.longitude!);
        });

        if (event.latitude != null && event.longitude != null) {
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(event.latitude!, event.longitude!),
                zoom: 18,
              ),
            ),
          );
          addMarker(center);
          getAddressFromLatLng(center);
        }
      });
    } catch (e) {
      print("exception : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  void didChangeDependencies() {
    userChangeLocation();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      physics: BouncingScrollPhysics(),
      children: [
        //header
        Container(
          width: double.infinity,
          height: AppBar().preferredSize.height,
          margin:
              EdgeInsets.fromLTRB(4, MediaQuery.of(context).padding.top, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(
                    "assets/images/clt.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Icon(Icons.drag_indicator_rounded)
            ],
          ),
        ),

        //sapaan
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Halo, User",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 5),
            Text(
              "Mau Kemana Hari ini?",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),

        SizedBox(height: 26),

        //bagian map
        Text("Lokasi kamu", style: TextStyle(fontSize: 18)),
        Container(
          width: double.infinity,
          height: 220,
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 10,
              ),
              markers: markers.values.toSet(),
              gestureRecognizers: Set()
                ..add(
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                ),
            ),
          ),
        ),

        //bagian nama lokasi dari map
        Row(
          children: [
            Icon(
              Icons.my_location_rounded,
              color: Color(0xFFF59D31),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                uAddress,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),

        SizedBox(height: 15),

        //list nama vendor
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vendor",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text("lihat semua"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: MediaQuery.of(context).size.width / 2),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFF6F4EF),
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        Icon(Icons
                            .android), //nanti di set logo / gambar vendor fixed size
                        Text("Nama vendor $index")
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),

        SizedBox(height: 15),

        //list nama truk
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daftar Truk",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text("lihat semua"),
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 180,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 25),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Card(
                    color: Color(0xffFAF6F0),
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/ic_splash.png",
                            fit: BoxFit.contain,
                            width: 170,
                            height: 100,
                          ),
                          Text(
                            "Nama Truk",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "Tipe",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFF59D31)),
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(CupertinoIcons.tray_arrow_up, size: 14),
                              Text(" Muatan : 10Kg")
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )
      ],
    ));
  }

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }
}
