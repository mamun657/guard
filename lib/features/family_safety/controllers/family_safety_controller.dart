import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../models/family_models.dart';
import '../services/battery_service.dart';
import '../services/device_identity_service.dart';
import '../services/family_exceptions.dart';
import '../services/family_repository.dart';
import '../services/location_provider.dart';
import '../services/location_sync_service.dart';
import '../services/sharing_service_bridge.dart';

enum CareLoadState { idle, loading, ready, error }

class FamilySafetyController extends ChangeNotifier {
  FamilySafetyController({
    required FamilyRepository repository,
    required DeviceIdentityService identityService,
    required BatteryService batteryService,
    required LocationSyncService syncService,
    required LocationProvider locationProvider,
    required SharingServiceBridge serviceBridge,
    required SharingServiceChannel serviceChannel,
    required FirebaseAuth auth,
  }) : _repository = repository,
       _identityService = identityService,
       _batteryService = batteryService,
       _syncService = syncService,
       _locationProvider = locationProvider,
       _serviceBridge = serviceBridge,
       _serviceChannel = serviceChannel,
       _auth = auth;

  final FamilyRepository _repository;
  final DeviceIdentityService _identityService;
  final BatteryService _batteryService;
  final LocationSyncService _syncService;
  final LocationProvider _locationProvider;
  final SharingServiceBridge _serviceBridge;
  final SharingServiceChannel _serviceChannel;
  final FirebaseAuth _auth;

  CareLoadState _loadState = CareLoadState.idle;
  String? _errorMessage;
  DeviceIdentity? _deviceIdentity;
  SharingState _sharingState = SharingState.notConfigured;
  DevicePresenceStatus _presence = DevicePresenceStatus.empty();
  SharedLocationRecord? _currentLocation;
  BatteryAssessment _battery = BatteryAssessment(
    level: -1,
    state: BatteryState.unknown,
    observedAt: DateTime.now().toUtc(),
  );
  List<AccessGrant> _grants = const [];
  List<ConnectionRequest> _requests = const [];
  List<ViewerAccessEntry> _viewerAccess = const [];
  final Map<String, SharedLocationRecord?> _watchedLocations = {};
  final Map<String, DevicePresenceStatus> _watchedPresence = {};
  FamilyInvitation? _activeInvitation;
  bool _isGuest = false;
  String _sharingSessionId = '';
  StreamSubscription<SharingLocationUpdate>? _serviceUpdatesSubscription;

  CareLoadState get loadState => _loadState;

  String? get errorMessage => _errorMessage;

  DeviceIdentity? get deviceIdentity => _deviceIdentity;

  SharingState get sharingState => _sharingState;

  DevicePresenceStatus get presence => _presence;

  SharedLocationRecord? get currentLocation => _currentLocation;

  BatteryAssessment get battery => _battery;

  List<AccessGrant> get grants => _grants;

  List<ConnectionRequest> get requests => _requests;

  List<ViewerAccessEntry> get viewerAccess => _viewerAccess;

  List<FamilyConnection> get authorizedConnections {
    final viewerUid = _auth.currentUser?.uid ?? '';
    return _viewerAccess.map((entry) {
      final key = _watchKey(entry.ownerUid, entry.deviceId);
      return FamilyConnection(
        ownerUid: entry.ownerUid,
        deviceId: entry.deviceId,
        grant: AccessGrant(
          viewerUid: viewerUid,
          ownerUid: entry.ownerUid,
          deviceId: entry.deviceId,
          grantedAt: entry.grantedAt,
          active: true,
          viewerDisplayName: entry.ownerDisplayName,
          relationship: entry.relationship,
        ),
        location: _watchedLocations[key],
        presence: _watchedPresence[key],
        ownerDisplayName: entry.ownerDisplayName,
        alias: entry.alias,
      );
    }).toList();
  }

  FamilyInvitation? get activeInvitation => _activeInvitation;

  bool get isGuest => _isGuest;

  String get sharingSessionId => _sharingSessionId;

  int get approvedViewerCount => _grants.where((grant) => grant.active).length;

  bool get hasApprovedViewers => approvedViewerCount > 0;

  Future<void> initialize({required bool isGuest}) async {
    _isGuest = isGuest;
    if (isGuest) {
      _loadState = CareLoadState.ready;
      _sharingState = SharingState.notConfigured;
      notifyListeners();
      return;
    }
    _loadState = CareLoadState.loading;
    notifyListeners();
    try {
      final deviceId = await _identityService.ensureDeviceId();
      final nickname = await _identityService.nicknameForDevice(deviceId);
      final user = _auth.currentUser;
      _deviceIdentity = DeviceIdentity(
        deviceId: deviceId,
        nickname: nickname,
        registeredOwnerUid: user?.uid ?? '',
      );
      await _repository.registerDevice(deviceId: deviceId, nickname: nickname);
      _presence = await _repository.readDeviceStatus(
        ownerUid: user?.uid ?? '',
        deviceId: deviceId,
      );
      _currentLocation = await _repository.readCurrentLocation(
        ownerUid: user?.uid ?? '',
        deviceId: deviceId,
      );
      _sharingState = _resolveSharingState(_presence);
      _battery = await _batteryService.read();
      await _refreshGrants();
      await _refreshRequests();
      await _refreshViewerAccess();
      _activeInvitation = await _repository.loadActiveInvitation(
        deviceId: deviceId,
      );
      _listenForServiceUpdates();
      _loadState = CareLoadState.ready;
      _errorMessage = null;
    } catch (error) {
      _loadState = CareLoadState.error;
      _errorMessage = error.toString();
    }
    notifyListeners();
  }

  void _listenForServiceUpdates() {
    _serviceUpdatesSubscription?.cancel();
    _serviceUpdatesSubscription = _serviceChannel.updates().listen((update) {
      unawaited(_handleServiceUpdate(update));
    });
  }

  Future<void> _handleServiceUpdate(SharingLocationUpdate update) async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    final result = await _syncService.publish(
      ownerUid: identity.registeredOwnerUid,
      deviceId: identity.deviceId,
      location: AcquiredLocation(
        latitude: update.latitude,
        longitude: update.longitude,
        accuracy: update.accuracy,
        capturedAt: update.capturedAt,
        altitude: 0,
        speed: 0,
      ),
      sharingSessionId: update.sessionId.isEmpty
          ? _sharingSessionId
          : update.sessionId,
    );
    if (result.accepted) {
      _battery = _battery.copyWith(
        level: result.record.batteryLevel,
        state: result.record.isCharging
            ? BatteryState.charging
            : BatteryState.discharging,
        observedAt: DateTime.now().toUtc(),
      );
      _presence = _presence.copyWith(
        sharingState: SharingState.active,
        lastSuccessfulUpload: DateTime.now().toUtc(),
        batteryLevel: result.record.batteryLevel,
        isCharging: result.record.isCharging,
      );
      notifyListeners();
    }
  }

  Future<bool> requestForegroundPermission() async {
    final permission = await _locationProvider.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _sharingState = SharingState.permissionDisabled;
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> isLocationServiceEnabled() {
    return _locationProvider.isServiceEnabled();
  }

  Future<LocationPermission> currentPermission() {
    return _locationProvider.checkPermission();
  }

  Future<bool> startSharing() async {
    final identity = _deviceIdentity;
    if (identity == null) return false;
    final serviceEnabled = await _locationProvider.isServiceEnabled();
    if (!serviceEnabled) {
      _errorMessage = 'location_service_disabled';
      notifyListeners();
      return false;
    }
    final permission = await _locationProvider.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      _sharingState = SharingState.permissionDisabled;
      notifyListeners();
      return false;
    }
    _sharingSessionId = _buildSessionId();
    final started = await _serviceBridge.start(
      sessionId: _sharingSessionId,
      intervalSeconds: 90,
      distanceFilterMeters: 20,
    );
    if (!started) {
      _errorMessage = 'service_start_failed';
      notifyListeners();
      return false;
    }
    try {
      _sharingState = SharingState.active;
      _errorMessage = null;
      await _repository.setDeviceSharingState(
        deviceId: identity.deviceId,
        state: SharingState.active,
      );
      await _syncService.publishStatus(
        ownerUid: identity.registeredOwnerUid,
        deviceId: identity.deviceId,
        state: SharingState.active,
        permissionState: 'granted',
      );
      await _captureInitialLocation(identity);
      notifyListeners();
      return true;
    } catch (error) {
      await _serviceBridge.stop();
      _sharingState = SharingState.stopped;
      _sharingSessionId = '';
      _errorMessage = error.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> _captureInitialLocation(DeviceIdentity identity) async {
    try {
      final location = await _locationProvider.currentPosition(
        timeLimit: const Duration(seconds: 25),
      );
      await _syncService.publish(
        ownerUid: identity.registeredOwnerUid,
        deviceId: identity.deviceId,
        location: location,
        sharingSessionId: _sharingSessionId,
      );
    } catch (_) {
      await _syncService.publishStatus(
        ownerUid: identity.registeredOwnerUid,
        deviceId: identity.deviceId,
        state: SharingState.active,
        permissionState: 'granted',
      );
    }
  }

  Future<void> pauseSharing() async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    await _serviceBridge.pause();
    _sharingState = SharingState.paused;
    await _repository.setDeviceSharingState(
      deviceId: identity.deviceId,
      state: SharingState.paused,
    );
    await _syncService.publishStatus(
      ownerUid: identity.registeredOwnerUid,
      deviceId: identity.deviceId,
      state: SharingState.paused,
      permissionState: 'granted',
    );
    notifyListeners();
  }

  Future<void> resumeSharing() async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    if (_sharingSessionId.isEmpty) {
      _sharingSessionId = _buildSessionId();
    }
    await _serviceBridge.resume(sessionId: _sharingSessionId);
    _sharingState = SharingState.active;
    await _repository.setDeviceSharingState(
      deviceId: identity.deviceId,
      state: SharingState.active,
    );
    await _syncService.publishStatus(
      ownerUid: identity.registeredOwnerUid,
      deviceId: identity.deviceId,
      state: SharingState.active,
      permissionState: 'granted',
    );
    notifyListeners();
  }

  Future<void> stopSharing() async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    await _serviceBridge.stop();
    _sharingState = SharingState.stopped;
    _sharingSessionId = '';
    await _repository.setDeviceSharingState(
      deviceId: identity.deviceId,
      state: SharingState.stopped,
    );
    await _syncService.publishStatus(
      ownerUid: identity.registeredOwnerUid,
      deviceId: identity.deviceId,
      state: SharingState.stopped,
      permissionState: 'granted',
    );
    notifyListeners();
  }

  Future<void> renameDevice(String nickname) async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    final trimmed = nickname.trim();
    if (trimmed.isEmpty) return;
    await _identityService.saveNickname(identity.deviceId, trimmed);
    _deviceIdentity = identity.copyWith(nickname: trimmed);
    await _repository.updateDeviceNickname(
      deviceId: identity.deviceId,
      nickname: trimmed,
    );
    notifyListeners();
  }

  Future<void> _refreshGrants() async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    _grants = await _repository.loadGrants(deviceId: identity.deviceId);
  }

  Future<void> _refreshRequests() async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    _requests = await _repository.loadIncomingRequests(
      deviceId: identity.deviceId,
    );
  }

  Future<void> _refreshViewerAccess() async {
    _viewerAccess = await _repository.loadViewerAccess();
    _watchedLocations.clear();
    _watchedPresence.clear();
    for (final entry in _viewerAccess) {
      final key = _watchKey(entry.ownerUid, entry.deviceId);
      _watchedLocations[key] = await _repository.readCurrentLocation(
        ownerUid: entry.ownerUid,
        deviceId: entry.deviceId,
      );
      _watchedPresence[key] = await _repository.readDeviceStatus(
        ownerUid: entry.ownerUid,
        deviceId: entry.deviceId,
      );
    }
  }

  String _watchKey(String ownerUid, String deviceId) =>
      '${ownerUid}__$deviceId';

  bool isOwnInvitation(FamilyInvitation invitation) {
    final uid = _auth.currentUser?.uid;
    return uid != null && uid == invitation.ownerUid;
  }

  Future<void> refresh() async {
    await _refreshGrants();
    await _refreshRequests();
    await _refreshViewerAccess();
    notifyListeners();
  }

  Future<FamilyInvitation> createInvitation() async {
    final identity = _deviceIdentity;
    if (identity == null) {
      throw StateError('Device is not registered.');
    }
    final invitation = await _repository.createInvitation(
      deviceId: identity.deviceId,
      deviceNickname: identity.nickname,
    );
    _activeInvitation = invitation;
    notifyListeners();
    return invitation;
  }

  Future<FamilyInvitation?> lookupInvitation(String code) async {
    final invitation = await _repository.readInvitation(code);
    _activeInvitation = invitation;
    notifyListeners();
    return invitation;
  }

  Future<void> cancelInvitation(String invitationId) async {
    await _repository.cancelInvitation(invitationId);
    if (_activeInvitation?.invitationId == invitationId) {
      _activeInvitation = _activeInvitation!.copyWith(status: 'cancelled');
    }
    notifyListeners();
  }

  Future<void> submitRequest({
    required FamilyInvitation invitation,
    required RelationshipType relationship,
  }) async {
    if (isOwnInvitation(invitation)) {
      throw FamilySafetyException(FamilySafetyErrorCode.selfInvitation);
    }
    await _repository.submitConnectionRequest(
      invitation: invitation,
      relationship: relationship,
    );
    notifyListeners();
  }

  Future<void> approveRequest(ConnectionRequest request) async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    await _repository.approveRequest(
      deviceId: identity.deviceId,
      request: request,
      relationship: request.relationship,
    );
    await _refreshGrants();
    await _refreshRequests();
    notifyListeners();
  }

  Future<void> rejectRequest(ConnectionRequest request) async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    await _repository.rejectRequest(
      deviceId: identity.deviceId,
      request: request,
    );
    await _refreshRequests();
    notifyListeners();
  }

  Future<void> revokeViewer(String viewerUid) async {
    final identity = _deviceIdentity;
    if (identity == null) return;
    await _repository.revokeViewer(
      deviceId: identity.deviceId,
      viewerUid: viewerUid,
    );
    await _refreshGrants();
    notifyListeners();
  }

  Future<void> removeConnection(FamilyConnection connection) async {
    await _repository.revokeAccessAsViewer(
      ownerUid: connection.ownerUid,
      deviceId: connection.deviceId,
    );
    await _refreshViewerAccess();
    notifyListeners();
  }

  Future<void> updateConnectionAlias(
    FamilyConnection connection,
    String alias,
  ) async {
    await _repository.updateViewerAlias(
      ownerUid: connection.ownerUid,
      deviceId: connection.deviceId,
      alias: alias,
    );
    await _refreshViewerAccess();
    notifyListeners();
  }

  SharingState _resolveSharingState(DevicePresenceStatus status) {
    switch (status.sharingState) {
      case SharingState.active:
        return SharingState.active;
      case SharingState.paused:
        return SharingState.paused;
      case SharingState.permissionDisabled:
        return SharingState.permissionDisabled;
      case SharingState.stopped:
        return SharingState.stopped;
      case SharingState.notConfigured:
        return SharingState.notConfigured;
    }
  }

  String _buildSessionId() {
    final now = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    return 'sess_$now';
  }

  @override
  void dispose() {
    _serviceUpdatesSubscription?.cancel();
    super.dispose();
  }
}
