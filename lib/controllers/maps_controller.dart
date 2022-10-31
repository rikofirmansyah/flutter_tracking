import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MapsController extends GetxController {
  final refDoc = FirebaseFirestore.instance.collection('loc_device').doc();
}
