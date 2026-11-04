import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/caresignal_controller.dart';
import 'controllers/family_safety_controller.dart';
import 'screens/family_safety_screen.dart';
import 'screens/caresignal_home_screen.dart';
import '../silent_speak/screens/silent_speak_mode_selection_screen.dart';
import 'services/battery_service.dart';
import 'services/caresignal_api.dart';
import 'services/caresignal_recorder.dart';
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
    final careSignalController = await _buildCareSignalController(
      auth: auth,
      identityService: identityService,
      languageCode: prefs.getString('language_code') ?? 'en',
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
      careSignalController: careSignalController,
    );
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            FamilySafetyScreen(controller: controller, isGuest: isGuest),
      ),
    );
    controller.dispose();
    careSignalController.dispose();
  }

  static Future<void> openCareSignal(
    BuildContext context, {
    required SharedPreferences prefs,
    required FirebaseAuth auth,
    NavigatorState? navigator,
    String? initialRequestId,
  }) async {
    final identityService = DeviceIdentityService(prefs);
    final controller = await _buildCareSignalController(
      auth: auth,
      identityService: identityService,
      languageCode: prefs.getString('language_code') ?? 'en',
    );
    if (!context.mounted) {
      controller.dispose();
      return;
    }
    final routeNavigator = navigator ?? Navigator.of(context);
    await routeNavigator.push(
      MaterialPageRoute<void>(
        builder: (_) => CareSignalHomeScreen(
          controller: controller,
          onBack: routeNavigator.pop,
          initialRequestId: initialRequestId,
        ),
      ),
    );
    controller.dispose();
  }

  static Future<void> openSilentSpeak(
    BuildContext context, {
    required SharedPreferences prefs,
    required FirebaseAuth auth,
  }) async {
    final identityService = DeviceIdentityService(prefs);
    final controller = await _buildCareSignalController(
      auth: auth,
      identityService: identityService,
      languageCode: prefs.getString('language_code') ?? 'en',
    );
    if (!context.mounted) {
      controller.dispose();
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SilentSpeakModeSelectionScreen(
          prefs: prefs,
          controller: controller,
        ),
      ),
    );
    controller.dispose();
  }

  static Future<CareSignalController> _buildCareSignalController({
    required FirebaseAuth auth,
    required DeviceIdentityService identityService,
    required String languageCode,
  }) async {
    final deviceId = await identityService.ensureDeviceId();
    final resolvedLanguage = languageCode == 'bn' ? 'bn' : 'bn-en';
    try {
      final config = CareSignalConfig.resolve();
      return CareSignalController(
        api: CareSignalApi(config: config, auth: auth),
        recorder: CareSignalRecorder(),
        deviceId: deviceId,
        languageCode: resolvedLanguage,
      );
    } catch (_) {
      return CareSignalController.unavailable(
        auth: auth,
        deviceId: deviceId,
        languageCode: resolvedLanguage,
      );
    }
  }
}
