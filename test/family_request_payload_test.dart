import 'package:amarguard/features/family_safety/services/family_error_messages.dart';
import 'package:amarguard/features/family_safety/services/family_exceptions.dart';
import 'package:amarguard/l10n/generated/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('invitation request payload omits deviceId', () {
    final requestPayload = <String, dynamic>{
      'viewerUid': 'viewer-1',
      'ownerUid': 'owner-1',
      'invitationId': 'ABC',
      'viewerDisplayName': 'Viewer',
      'viewerEmail': 'viewer@example.com',
      'relationship': 'friend',
      'requestedCapabilities': const ['viewLocation', 'viewBattery'],
      'status': 'pending',
    };
    expect(requestPayload.containsKey('deviceId'), isFalse);
    expect(
      requestPayload.keys.toSet(),
      {
        'viewerUid',
        'ownerUid',
        'invitationId',
        'viewerDisplayName',
        'viewerEmail',
        'relationship',
        'requestedCapabilities',
        'status',
      },
    );
  });

  test('incoming request payload includes deviceId', () {
    final requestPayload = <String, dynamic>{
      'viewerUid': 'viewer-1',
      'ownerUid': 'owner-1',
      'invitationId': 'ABC',
      'viewerDisplayName': 'Viewer',
      'viewerEmail': 'viewer@example.com',
      'relationship': 'friend',
      'requestedCapabilities': const ['viewLocation', 'viewBattery'],
      'status': 'pending',
    };
    final incomingPayload = <String, dynamic>{
      ...requestPayload,
      'deviceId': 'device-1',
    };
    expect(incomingPayload['deviceId'], 'device-1');
    expect(
      incomingPayload.keys.toSet(),
      {
        'viewerUid',
        'ownerUid',
        'deviceId',
        'invitationId',
        'viewerDisplayName',
        'viewerEmail',
        'relationship',
        'requestedCapabilities',
        'status',
      },
    );
  });

  test('maps family safety errors to useful copy', () {
    final l10n = AppLocalizationsEn();
    expect(
      familySafetyErrorMessage(
        l10n,
        FamilySafetyException(FamilySafetyErrorCode.selfInvitation),
      ),
      l10n.careSelfInvitation,
    );
    expect(
      familySafetyErrorMessage(
        l10n,
        FamilySafetyException(FamilySafetyErrorCode.invitationExpired),
      ),
      l10n.careInvitationExpired,
    );
    expect(
      familySafetyErrorMessage(
        l10n,
        FamilySafetyException(FamilySafetyErrorCode.permissionDenied),
      ),
      l10n.careInvitationPermissionDenied,
    );
    expect(
      familySafetyErrorMessage(
        l10n,
        FamilySafetyException(FamilySafetyErrorCode.network),
      ),
      l10n.errorNoInternet,
    );
  });
}
