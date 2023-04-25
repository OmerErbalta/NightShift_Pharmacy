import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:nobetci_eczane/model/eczane.dart';

import 'all_methods.dart';

final cilent = Provider<Dio>((ref) {
  return Dio(BaseOptions(
      baseUrl:
          'https://www.nosyapi.com/apiv2/pharmacyLink?apikey=YOUR_APİKEY'));
});

final getAdress = FutureProvider<Placemark>(((ref) async {
  Position location = await getLocation();

  return await (getLocationFromAddress(location.latitude, location.longitude));
}));
final getPosition = FutureProvider<Position>(((ref) {
  return getLocation();
}));

final eczaneListesiGetir = FutureProvider<List<Eczane>>(((ref) async {
  final _dio = ref.watch(cilent);
  final adress = ref.watch(getAdress);
  print(adress);
  String il = "istanbul";
  String ilce = "";
  il = toEnglish(adress.value!.administrativeArea.toString());
  ilce = toEnglish(adress.value!.subAdministrativeArea.toString());

  final _result = await _dio.get('&city=$il');
  print(_result.data["data"]);
  List<Map<String, dynamic>> _mapData = List.from(_result.data['data']);
  List<Eczane> _eczaneList = _mapData.map((e) => Eczane.fromMap(e)).toList();
  return _eczaneList;
}));
