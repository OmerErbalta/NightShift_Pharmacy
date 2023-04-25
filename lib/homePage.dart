import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nobetci_eczane/all_methods.dart';

import 'all_providers.dart';
import 'model/eczane.dart';
import 'widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

final Completer<GoogleMapController> mapController =
    Completer<GoogleMapController>();

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var eczaneListesi = ref.watch(eczaneListesiGetir);
    var latlng = ref.watch(getPosition);
    return Scaffold(
      appBar: AppBar(
          leading: const TitleWidget(), title: const Text("Nöbetci Eczaneler")),
      body: Center(
        child: eczaneListesi.when(
          data: ((data) {
            return latlng.when(data: ((location) {
              data.sort(
                (a, b) {
                  return a
                      .calculateDistance(a.latitude, a.longitude,
                          location.latitude, location.longitude)
                      .compareTo(b.calculateDistance(b.latitude, b.longitude,
                          location.latitude, location.longitude));
                },
              );
              return Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      width: 400,
                      height: 300,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        indoorViewEnabled: true,
                        mapType: MapType.normal,
                        markers: setMarkers(data),
                        initialCameraPosition: CameraPosition(
                            target:
                                LatLng(location.latitude, location.longitude),
                            zoom: 12),
                        onMapCreated: (GoogleMapController controller) {
                          mapController.complete(controller);
                        },
                      )),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          return eczaneCard(data, index, location);
                        })),
                  ),
                ],
              );
            }), error: ((error, stackTrace) {
              return const Icon(Icons.error);
            }), loading: (() {
              return Container();
            }));
          }),
          error: ((error, stackTrace) {
            return Text(error.toString());
          }),
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
