import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nobetci_eczane/getLocation.dart';

import 'model/eczane.dart';

Future<Position> getLocation() async {
  late Position getPosition;
  final geolocatorController = Get.put(GeolocatorController());
  await Geolocator.requestPermission().then((request) async {
    print("REQUEST : $request");
    if (request != LocationPermission.whileInUse) {
      print("NOT LOCATION PERMISSION");
      return;
    } else {
      print("PERMISSION OK");
      getPosition = await (geolocatorController.permissionOK());
    }
  });
  return getPosition;
}

Future<Placemark> getLocationFromAddress(
    double latitude, double longitude) async {
  print("object");
  print(latitude);
  print(longitude);

  List<Placemark> placemarks =
      await (placemarkFromCoordinates(latitude, longitude));
  Placemark placemark = placemarks.first;
  print('Country: ${placemark.country}');
  print('City: ${placemark.administrativeArea}');
  return placemark;
}

String toEnglish(String str) {
  str = str.toLowerCase();
  String newString = str
      .replaceAll("ç", "c")
      .replaceAll("ı", "i")
      .replaceAll("ş", "s")
      .replaceAll("ğ", "g")
      .replaceAll("ö", "o")
      .replaceAll("ü", "u");
  return newString;
}

Set<Marker> setMarkers(List<Eczane> liste) {
  List<Marker> markerList = [];
  liste.forEach((element) {
    markerList.add(
      Marker(
          infoWindow:
              InfoWindow(title: element.EczaneAdi, snippet: element.Telefon),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          markerId: MarkerId(element.EczaneAdi),
          position: LatLng(element.latitude, element.longitude)),
    );
  });

  return markerList.toSet();
}
