import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../data/location_model.dart';

class HistoryController extends GetxController {
  final refDoc =
      FirebaseFirestore.instance.collection('loc_device').snapshots();

  // Stream<List<LocationModel>> get locationStream => refDoc.map((doc) {
  //       return doc
  //           .data()!
  //           .entries
  //           .map((e) => LocationModel.fromJson(e.value as Map<String, dynamic>))
  //           .toList();
  //     });

  @override
  void onInit() {
    super.onInit();
  }
}
