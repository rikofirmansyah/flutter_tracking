import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracking/Screens/account.dart';
import 'package:device_tracking/Screens/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:device_tracking/Screens/Login_Screen.dart';
import 'package:device_tracking/Screens/maps.dart';
import 'package:device_tracking/Screens/account.dart';
import 'package:device_tracking/Component/header_drawer.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final locRef = FirebaseFirestore.instance.collection('loc_device');
var scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(children: [
            const MyHeaderDrawer(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Map Display"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active_rounded),
              title: const Text("Notification"),
              onTap: () async {
                final doc = FirebaseFirestore.instance.collection("loc_device");
                final refDoc = doc.doc();
                await refDoc.set({
                  "coords": GeoPoint(0.562, 101.4),
                  "id": refDoc.id,
                  "kemiringan": "204",
                  "place": "Jl. Raya Cikarang",
                  "time": DateTime.now(),
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Reset"),
              onTap: () async {
                var snapshot = await FirebaseFirestore.instance
                    .collection("loc_device")
                    .orderBy("time")
                    .get();
                for (var i = 0; i < snapshot.docs.length; i++) {
                  if (i + 1 == snapshot.docs.length) {
                    break;
                  } else {
                    await FirebaseFirestore.instance
                        .collection("loc_device")
                        .doc(snapshot.docs[i].id)
                        .delete();
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                _firebaseAuth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Device Tracking"),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(25),
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              splashColor: Colors.lightBlueAccent,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/device.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Text(
                    'Device',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              )),
            ),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Maps()));
              },
              splashColor: Colors.lightBlueAccent,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/maps.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Text(
                    'Maps',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              )),
            ),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const History()));
              },
              splashColor: Colors.lightBlueAccent,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/history.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              )),
            ),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()));
              },
              splashColor: Colors.lightBlueAccent,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/account.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              )),
            ),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              splashColor: Colors.lightBlueAccent,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/sos.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Text(
                    'SOS',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              )),
            ),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          ),
        ],
      ),
    );
  }
}
