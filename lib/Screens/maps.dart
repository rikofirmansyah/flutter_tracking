import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracking/data/location_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps Device"),
      ),
      body: StreamBuilder<LocationModel>(
        stream: FirebaseFirestore.instance
            .collection('loc_device')
            .snapshots()
            .map((doc) {
          return doc.docs
              .map((e) => LocationModel.fromJson(e.data()))
              .toList()
              .last;
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  snapshot.data?.coordinates?.latitude ?? 0,
                  snapshot.data?.coordinates?.longitude ?? 0,
                ),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("device"),
                  position: LatLng(
                    snapshot.data?.coordinates?.latitude ?? 0,
                    snapshot.data?.coordinates?.longitude ?? 0,
                  ),
                )
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
