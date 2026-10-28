import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/family_safety_controller.dart';
import 'screens/family_safety_screen.dart';
import 'services/battery_service.dart';
import 'services/device_identity_service.dart';
import 'services/family_repository.dart';
import 'services/location_provider.dart';
import 'services/location_sync_service.dart';
import 'services/sharing_service_bridge.dart';

class FamilySafetyLauncher {
  FamilySafetyLauncher._();

  static Future<void> open(
    BuildContext context, {
    required bool isGuest,
    required SharedPreferences prefs,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) async {
    final repository = FamilyRepository(firestore, auth);
    final identityService = DeviceIdentityService(prefs);
    final batteryService = BatteryService();
    final syncService = LocationSyncService(
      repository: repository,
      batteryService: batteryService,
    );
    final controller = FamilySafetyController(
      repository: repository,
      identityService: identityService,
      batteryService: batteryService,
      syncService: syncService,
      locationProvider: const GeolocatorLocationProvider(),
      serviceBridge: SharingServiceBridge(),
      serviceChannel: SharingServiceChannel(),
      auth: auth,
    );
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => FamilySafetyScreen(
          controller: controller,
          isGuest: isGuest,
        ),
      ),
    );
    controller.dispose();
  }
}
