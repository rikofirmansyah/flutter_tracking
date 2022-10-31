import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracking/controllers/history_controller.dart';
import 'package:device_tracking/data/location_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends GetView<HistoryController> {
  const History({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        elevation: 0,
      ),
      body: StreamBuilder<List<LocationModel>>(
        stream: controller.refDoc.map((doc) {
          return doc.docs
              .map((e) => LocationModel.fromJson(e.data()))
              .toList()
              .reversed
              .toList();
        }),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                var date = DateTime.fromMicrosecondsSinceEpoch(
                  data?[index].time?.microsecondsSinceEpoch ?? 0,
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.grey[200],
                    title:
                        Text(data?[index].place.toString().toUpperCase() ?? ""),
                    subtitle: Text(
                        "Koordinat: [${data?[index].coordinates?.latitude.toString()},${data?[index].coordinates?.longitude.toString()}] \nWaktu: $date\nKemiringan: ${data?[index].kemiringan.toString()}"),
                    leading: const CircleAvatar(child: Icon(Icons.location_on)),
                  ),
                );
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
