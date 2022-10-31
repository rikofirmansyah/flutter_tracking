import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final GeoPoint? coordinates;
  final String? place;
  final String? kemiringan;
  final Timestamp? time;

  LocationModel({
    this.coordinates,
    this.place,
    this.kemiringan,
    this.time,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      coordinates: json['coords'] as GeoPoint?,
      place: json['place'] as String?,
      kemiringan: json['kemiringan'] as String?,
      time: json['time'] as Timestamp?,
    );
  }
}
