import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/family_models.dart';
import 'family_exceptions.dart';
import 'family_paths.dart';
import 'secure_token.dart';

class FamilyRepository {
  FamilyRepository(this._firestore, this._auth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  static const Duration invitationLifetime = Duration(hours: 48);

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) {
      throw FamilySafetyException(FamilySafetyErrorCode.unauthenticated);
    }
    return user.uid;
  }

  bool get isSignedIn => _auth.currentUser != null;

  Future<void> registerDevice({
    required String deviceId,
    required String nickname,
  }) async {
    final ownerUid = _uid;
    final doc = FamilyPaths.deviceDoc(ownerUid, deviceId);
    final existing = await doc.get();
    if (!existing.exists) {
      await doc.set({
        'ownerUid': ownerUid,
        'deviceId': deviceId,
        'nickname': nickname,
        'sharingState': SharingState.stopped.name,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return;
    }
    await doc.set({
      'nickname': nickname,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> updateDeviceNickname({
    required String deviceId,
    required String nickname,
  }) async {
    await FamilyPaths.deviceDoc(_uid, deviceId).set({
      'nickname': nickname,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> setDeviceSharingState({
    required String deviceId,
    required SharingState state,
  }) async {
    await FamilyPaths.deviceDoc(_uid, deviceId).set({
      'sharingState': state.name,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<DevicePresenceStatus> readDeviceStatus({
    required String ownerUid,
    required String deviceId,
  }) async {
    final snapshot = await FamilyPaths.statusDoc(ownerUid, deviceId).get();
    if (!snapshot.exists) return DevicePresenceStatus.empty();
    final data = snapshot.data();
    if (data == null) return DevicePresenceStatus.empty();
    return DevicePresenceStatus.fromFirestore(data);
  }

  Stream<SharedLocationRecord?> watchCurrentLocation({
    required String ownerUid,
    required String deviceId,
  }) {
    return FamilyPaths.locationDoc(ownerUid, deviceId).snapshots().map((
      snapshot,
    ) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) return null;
      return SharedLocationRecord.fromFirestore(
        data,
        ownerUid: ownerUid,
        deviceId: deviceId,
        serverReceiptFallback: snapshot.metadata.hasPendingWrites ? null : null,
      );
    });
  }

  Future<SharedLocationRecord?> readCurrentLocation({
    required String ownerUid,
    required String deviceId,
  }) async {
    final snapshot = await FamilyPaths.locationDoc(ownerUid, deviceId).get();
    final data = snapshot.data();
    if (!snapshot.exists || data == null) return null;
    return SharedLocationRecord.fromFirestore(
      data,
      ownerUid: ownerUid,
      deviceId: deviceId,
      serverReceiptFallback: null,
    );
  }

  Future<FamilyInvitation> createInvitation({
    required String deviceId,
    required String deviceNickname,
  }) async {
    final ownerUid = _uid;
    final ownerDisplayName = _auth.currentUser?.displayName?.trim() ?? '';
    final token = SecureToken.generate();
    final now = DateTime.now().toUtc();
    final expiresAt = now.add(invitationLifetime);
    final doc = FamilyPaths.invitationDoc(token);
    await doc.set({
      'ownerUid': ownerUid,
      'ownerDisplayName': ownerDisplayName,
      'deviceId': deviceId,
      'deviceNickname': deviceNickname,
      'status': 'open',
      'requestedCapabilities': const ['viewLocation', 'viewBattery'],
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt': Timestamp.fromDate(expiresAt),
    });
    return FamilyInvitation(
      invitationId: token,
      ownerUid: ownerUid,
      ownerDisplayName: ownerDisplayName.isEmpty
          ? 'AmarGuard user'
          : ownerDisplayName,
      createdAt: now,
      expiresAt: expiresAt,
      status: 'open',
      deviceId: deviceId,
      deviceNickname: deviceNickname,
      requestedCapabilities: const ['viewLocation', 'viewBattery'],
    );
  }

  Future<FamilyInvitation?> readInvitation(String rawCode) async {
    final token = SecureToken.normalize(rawCode);
    if (token.isEmpty) return null;
    try {
      final snapshot = await _firestore
          .collection(FamilyPaths.invitations)
          .doc(token)
          .get();
      if (!snapshot.exists) return null;
      final data = snapshot.data();
      if (data == null) return null;
      return FamilyInvitation.fromFirestore(data, invitationId: token);
    } on FirebaseException catch (error) {
      debugPrint(
        'FamilySafety readInvitation code=${error.code} message=${error.message}',
      );
      if (error.code == 'permission-denied' || error.code == 'not-found') {
        return null;
      }
      throw FamilySafetyException.fromFirebase(error);
    }
  }

  Future<FamilyInvitation?> loadActiveInvitation({
    required String deviceId,
  }) async {
    final snapshot = await _firestore
        .collection(FamilyPaths.invitations)
        .where('ownerUid', isEqualTo: _uid)
        .get();
    for (final doc in snapshot.docs.reversed) {
      final invitation = FamilyInvitation.fromFirestore(
        doc.data(),
        invitationId: doc.id,
      );
      if (invitation.deviceId == deviceId && invitation.isOpen) {
        return invitation;
      }
    }
    return null;
  }

  Future<void> cancelInvitation(String invitationId) async {
    await FamilyPaths.invitationDoc(invitationId).set({
      'status': 'cancelled',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<ConnectionRequest> submitConnectionRequest({
    required FamilyInvitation invitation,
    required RelationshipType relationship,
  }) async {
    final viewerUid = _uid;
    final viewer = _auth.currentUser;
    final deviceId = invitation.deviceId?.trim() ?? '';
    if (deviceId.isEmpty) {
      throw FamilySafetyException(FamilySafetyErrorCode.invalidInvitation);
    }
    if (viewerUid == invitation.ownerUid) {
      throw FamilySafetyException(FamilySafetyErrorCode.selfInvitation);
    }
    debugPrint(
      'FamilySafety submitConnectionRequest viewer=$viewerUid owner=${invitation.ownerUid} device=$deviceId invitation=${invitation.invitationId}',
    );

    final invitationRef = _firestore
        .collection(FamilyPaths.invitations)
        .doc(invitation.invitationId);
    final requestRef = invitationRef
        .collection(FamilyPaths.requests)
        .doc(viewerUid);
    final incomingRef = _firestore
        .collection(FamilyPaths.users)
        .doc(invitation.ownerUid)
        .collection(FamilyPaths.devices)
        .doc(deviceId)
        .collection(FamilyPaths.incomingRequests)
        .doc(viewerUid);

    try {
      final result = await _firestore.runTransaction((transaction) async {
        final invitationSnap = await transaction.get(invitationRef);
        if (!invitationSnap.exists) {
          return (
            error: FamilySafetyErrorCode.invitationNotFound,
            request: null,
          );
        }
        final invitationData =
            invitationSnap.data() ?? const <String, dynamic>{};
        final liveInvitation = FamilyInvitation.fromFirestore(
          invitationData,
          invitationId: invitation.invitationId,
        );
        final liveDeviceId = liveInvitation.deviceId?.trim() ?? '';
        if (liveDeviceId.isEmpty) {
          return (
            error: FamilySafetyErrorCode.invalidInvitation,
            request: null,
          );
        }
        if (liveInvitation.ownerUid == viewerUid) {
          return (error: FamilySafetyErrorCode.selfInvitation, request: null);
        }
        if (liveInvitation.ownerUid != invitation.ownerUid ||
            liveDeviceId != deviceId) {
          return (
            error: FamilySafetyErrorCode.invalidInvitation,
            request: null,
          );
        }
        if (liveInvitation.status != 'open') {
          return (error: FamilySafetyErrorCode.invitationClosed, request: null);
        }
        if (liveInvitation.isExpired) {
          return (
            error: FamilySafetyErrorCode.invitationExpired,
            request: null,
          );
        }

        final existingRequest = await transaction.get(requestRef);
        if (existingRequest.exists) {
          final existing = ConnectionRequest.fromFirestore(
            existingRequest.data() ?? const <String, dynamic>{},
            viewerUid: viewerUid,
            invitationId: invitation.invitationId,
            ownerUid: liveInvitation.ownerUid,
          );
          if (existing.isPending) {
            return (
              error: FamilySafetyErrorCode.duplicateRequest,
              request: null,
            );
          }
          return (error: FamilySafetyErrorCode.alreadyProcessed, request: null);
        }

        final viewerDisplayName = viewer?.displayName?.trim() ?? '';
        final viewerEmail = viewer?.email ?? '';
        final requestedAt = Timestamp.now();
        final requestPayload = <String, dynamic>{
          'viewerUid': viewerUid,
          'ownerUid': liveInvitation.ownerUid,
          'invitationId': invitation.invitationId,
          'viewerDisplayName': viewerDisplayName,
          'viewerEmail': viewerEmail,
          'relationship': relationship.name,
          'requestedCapabilities': liveInvitation.requestedCapabilities,
          'status': 'pending',
          'requestedAt': requestedAt,
        };
        final incomingPayload = <String, dynamic>{
          ...requestPayload,
          'deviceId': liveDeviceId,
        };
        transaction.set(requestRef, requestPayload);
        transaction.set(incomingRef, incomingPayload);
        return (
          error: null,
          request: ConnectionRequest(
            viewerUid: viewerUid,
            invitationId: invitation.invitationId,
            ownerUid: liveInvitation.ownerUid,
            viewerDisplayName: viewerDisplayName,
            viewerEmail: viewerEmail,
            requestedAt: requestedAt.toDate(),
            status: 'pending',
            relationship: relationship,
            requestedCapabilities: liveInvitation.requestedCapabilities,
          ),
        );
      });
      if (result.error != null) {
        throw FamilySafetyException(result.error!);
      }
      return result.request!;
    } on FamilySafetyException {
      rethrow;
    } on FirebaseException catch (error) {
      debugPrint(
        'FamilySafety submitConnectionRequest code=${error.code} message=${error.message}',
      );
      throw FamilySafetyException.fromFirebase(error);
    }
  }

  Stream<List<ConnectionRequest>> watchIncomingRequests({
    required String deviceId,
  }) {
    final ownerUid = _uid;
    return _firestore
        .collection(FamilyPaths.users)
        .doc(ownerUid)
        .collection(FamilyPaths.devices)
        .doc(deviceId)
        .collection(FamilyPaths.incomingRequests)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ConnectionRequest.fromFirestore(
                  doc.data(),
                  viewerUid: doc.id,
                  invitationId: (doc.data()['invitationId'] as String?) ?? '',
                  ownerUid: ownerUid,
                ),
              )
              .toList(),
        );
  }

  Future<List<ConnectionRequest>> loadIncomingRequests({
    required String deviceId,
  }) async {
    final ownerUid = _uid;
    final snapshot = await _firestore
        .collection(FamilyPaths.users)
        .doc(ownerUid)
        .collection(FamilyPaths.devices)
        .doc(deviceId)
        .collection(FamilyPaths.incomingRequests)
        .get();
    return snapshot.docs
        .map(
          (doc) => ConnectionRequest.fromFirestore(
            doc.data(),
            viewerUid: doc.id,
            invitationId: (doc.data()['invitationId'] as String?) ?? '',
            ownerUid: ownerUid,
          ),
        )
        .toList();
  }

  Future<AccessGrant> approveRequest({
    required String deviceId,
    required ConnectionRequest request,
    required RelationshipType relationship,
  }) async {
    final ownerUid = _uid;
    final grantDoc = FamilyPaths.grantDoc(
      ownerUid,
      deviceId,
      request.viewerUid,
    );
    await grantDoc.set({
      'viewerUid': request.viewerUid,
      'ownerUid': ownerUid,
      'deviceId': deviceId,
      'invitationId': request.invitationId,
      'active': true,
      'relationship': relationship.name,
      'viewerDisplayName': request.viewerDisplayName,
      'viewerEmail': request.viewerEmail,
      'grantedAt': FieldValue.serverTimestamp(),
    });
    await _writeViewerIndex(
      viewerUid: request.viewerUid,
      ownerUid: ownerUid,
      deviceId: deviceId,
      ownerDisplayName: _auth.currentUser?.displayName?.trim() ?? '',
      relationship: relationship,
    );
    await FamilyPaths.requestDoc(request.invitationId, request.viewerUid).set({
      'status': 'approved',
      'approvedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    await FamilyPaths.deviceDoc(
      ownerUid,
      deviceId,
    ).collection(FamilyPaths.incomingRequests).doc(request.viewerUid).set({
      'status': 'approved',
      'approvedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return AccessGrant(
      viewerUid: request.viewerUid,
      ownerUid: ownerUid,
      deviceId: deviceId,
      grantedAt: DateTime.now().toUtc(),
      active: true,
      viewerDisplayName: request.viewerDisplayName,
      viewerEmail: request.viewerEmail,
      relationship: relationship,
    );
  }

  Future<void> rejectRequest({
    required String deviceId,
    required ConnectionRequest request,
  }) async {
    final ownerUid = _uid;
    await FamilyPaths.requestDoc(request.invitationId, request.viewerUid).set({
      'status': 'rejected',
      'rejectedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    await FamilyPaths.deviceDoc(
      ownerUid,
      deviceId,
    ).collection(FamilyPaths.incomingRequests).doc(request.viewerUid).set({
      'status': 'rejected',
      'rejectedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    await FamilyPaths.invitationDoc(request.invitationId).set({
      'status': 'closed',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> revokeViewer({
    required String deviceId,
    required String viewerUid,
  }) async {
    final ownerUid = _uid;
    await FamilyPaths.grantDoc(ownerUid, deviceId, viewerUid).delete();
    await _firestore
        .collection('familyViewerAccess')
        .doc(viewerUid)
        .collection('grants')
        .doc(_viewerIndexId(ownerUid, deviceId))
        .delete();
  }

  Future<void> revokeAccessAsViewer({
    required String ownerUid,
    required String deviceId,
  }) async {
    final viewerUid = _uid;
    await FamilyPaths.grantDoc(ownerUid, deviceId, viewerUid).delete();
    await _firestore
        .collection('familyViewerAccess')
        .doc(viewerUid)
        .collection('grants')
        .doc(_viewerIndexId(ownerUid, deviceId))
        .delete();
  }

  Future<void> updateViewerAlias({
    required String ownerUid,
    required String deviceId,
    required String alias,
  }) async {
    await _firestore
        .collection('familyViewerAccess')
        .doc(_uid)
        .collection('grants')
        .doc(_viewerIndexId(ownerUid, deviceId))
        .set({'alias': alias.trim()}, SetOptions(merge: true));
  }

  Stream<List<AccessGrant>> watchGrants({required String deviceId}) {
    final ownerUid = _uid;
    return FamilyPaths.grantCollection(ownerUid, deviceId).snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => AccessGrant.fromFirestore(
              doc.data(),
              ownerUid: ownerUid,
              deviceId: deviceId,
              viewerUid: doc.id,
            ),
          )
          .toList(),
    );
  }

  Future<List<AccessGrant>> loadGrants({required String deviceId}) async {
    final ownerUid = _uid;
    final snapshot = await FamilyPaths.grantCollection(
      ownerUid,
      deviceId,
    ).get();
    return snapshot.docs
        .map(
          (doc) => AccessGrant.fromFirestore(
            doc.data(),
            ownerUid: ownerUid,
            deviceId: deviceId,
            viewerUid: doc.id,
          ),
        )
        .toList();
  }

  Stream<List<ViewerAccessEntry>> watchViewerAccess() {
    final viewerUid = _uid;
    return _firestore
        .collection('familyViewerAccess')
        .doc(viewerUid)
        .collection('grants')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ViewerAccessEntry.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<List<ViewerAccessEntry>> loadViewerAccess() async {
    final viewerUid = _uid;
    final snapshot = await _firestore
        .collection('familyViewerAccess')
        .doc(viewerUid)
        .collection('grants')
        .get();
    return snapshot.docs
        .map((doc) => ViewerAccessEntry.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<void> _writeViewerIndex({
    required String viewerUid,
    required String ownerUid,
    required String deviceId,
    required String ownerDisplayName,
    required RelationshipType relationship,
  }) async {
    await _firestore
        .collection('familyViewerAccess')
        .doc(viewerUid)
        .collection('grants')
        .doc(_viewerIndexId(ownerUid, deviceId))
        .set({
          'ownerUid': ownerUid,
          'deviceId': deviceId,
          'ownerDisplayName': ownerDisplayName,
          'relationship': relationship.name,
          'grantedAt': FieldValue.serverTimestamp(),
        });
  }

  String _viewerIndexId(String ownerUid, String deviceId) {
    return '${ownerUid}__$deviceId';
  }
}

class ViewerAccessEntry {
  const ViewerAccessEntry({
    required this.ownerUid,
    required this.deviceId,
    required this.ownerDisplayName,
    required this.relationship,
    required this.grantedAt,
    this.alias,
  });

  final String ownerUid;
  final String deviceId;
  final String ownerDisplayName;
  final RelationshipType relationship;
  final DateTime grantedAt;
  final String? alias;

  static ViewerAccessEntry fromFirestore(Map<String, dynamic> data, String id) {
    final rawRelationship = data['relationship'];
    final relationship = RelationshipType.values.firstWhere(
      (item) => item.name == rawRelationship,
      orElse: () => RelationshipType.other,
    );
    final grantedAt = data['grantedAt'];
    return ViewerAccessEntry(
      ownerUid: (data['ownerUid'] as String?) ?? '',
      deviceId: (data['deviceId'] as String?) ?? '',
      ownerDisplayName:
          (data['ownerDisplayName'] as String?) ?? 'Family member',
      alias: data['alias'] as String?,
      relationship: relationship,
      grantedAt: grantedAt is Timestamp
          ? grantedAt.toDate()
          : DateTime.tryParse('${grantedAt ?? ''}') ?? DateTime.now().toUtc(),
    );
  }
}
