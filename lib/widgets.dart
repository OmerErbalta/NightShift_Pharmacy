import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nobetci_eczane/all_methods.dart';
import 'package:nobetci_eczane/homePage.dart';

import 'model/eczane.dart';

class TitleWidget extends ConsumerWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Image.asset("assets/images/logo2.png"),
    );
  }
}

Container eczaneCard(List<Eczane> data, int index, Position location) {
  return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.place),
              title: Text(data[index].EczaneAdi),
              subtitle: Text(data[index].Telefon.substring(2)),
            ),
            ButtonBarTheme(
              data: ButtonBarThemeData(),
              child: ButtonBar(
                children: <Widget>[
                  IconButton(
                    padding: const EdgeInsets.fromLTRB(10, 10, 25, 5),
                    icon: const Icon(Icons.map),
                    color: Colors.blue,
                    onPressed: () async {
                      final GoogleMapController controller =
                          await mapController.future;

                      controller.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              zoom: 14,
                              target: LatLng(data[index].latitude,
                                  data[index].longitude))));
                      controller.showMarkerInfoWindow(
                          MarkerId(data[index].EczaneAdi));
                    },
                  ),
                  IconButton(
                    padding: const EdgeInsets.fromLTRB(10, 10, 25, 5),
                    icon: const Icon(Icons.call),
                    color: Colors.blue,
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(data[index].Telefon);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
