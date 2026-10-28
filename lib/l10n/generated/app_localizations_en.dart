// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AmarGuard';

  @override
  String get brandTagline => 'UNDERSTAND BEFORE YOU TRUST.';

  @override
  String get splashCredit => 'by BinaryPulse';

  @override
  String get onboardingTitle1 => 'Stay safer in every\ndigital interaction.';

  @override
  String get onboardingSubtitle1 =>
      'Detect, understand and respond to risky\ncalls, messages, links and screenshots.';

  @override
  String get onboardingTitle2 => 'Scams don\'t always\nstart with a link.';

  @override
  String get onboardingSubtitle2 =>
      'Sometimes, they start with\na conversation.';

  @override
  String get onboardingTitle3 => 'Know why something\nfeels risky.';

  @override
  String get onboardingSubtitle3 =>
      'AI analyzes the whole interaction\nand explains the risk.';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get scamBubble1 => 'You\'ve been selected\nfor a special offer!';

  @override
  String get scamBubble2 => 'Pay now to confirm.';

  @override
  String get scamBubble3 => 'Don\'t tell anyone.';

  @override
  String get scamBubble4 => 'Share your OTP.';

  @override
  String get pipelineStep1Title => 'Conversation';

  @override
  String get pipelineStep1Subtitle => 'Voice to Text';

  @override
  String get pipelineStep2Title => 'Context Analysis';

  @override
  String get pipelineStep2Subtitle => 'Find risk signals';

  @override
  String get pipelineStep3Title => 'AI Risk Detection';

  @override
  String get pipelineStep3Subtitle => 'XGBoost + SHAP';

  @override
  String get pipelineStep4Title => 'Clear Explanation';

  @override
  String get pipelineStep4Subtitle => 'Why is it risky?';

  @override
  String get loginWelcome => 'Welcome Back';

  @override
  String get loginSubtitle => 'Log in to keep a safer digital life.';

  @override
  String get loginEmailHint => 'Email Address';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginKeepMe => 'Keep me signed in';

  @override
  String get loginForgot => 'Forgot Password?';

  @override
  String get loginButton => 'Log In';

  @override
  String get loginContinueAs => 'or continue as';

  @override
  String get loginGuest => 'Continue as Guest';

  @override
  String get loginNoAccount => 'Don\'t have an account? ';

  @override
  String get loginSignUp => 'Sign Up';

  @override
  String get signupTitle => 'Create Your\nSafety Account';

  @override
  String get signupSubtitle => 'Join AmarGuard and stay protected.';

  @override
  String get signupNameHint => 'Full Name';

  @override
  String get signupEmailHint => 'Email Address';

  @override
  String get signupPhoneHint => 'Phone Number';

  @override
  String get signupPasswordHint => 'Password';

  @override
  String get signupConfirmHint => 'Confirm Password';

  @override
  String get signupAgreePrefix => 'I agree to the ';

  @override
  String get signupAgreePrivacy => 'Privacy Policy';

  @override
  String get signupAgreeAnd => ' and ';

  @override
  String get signupAgreeTerms => 'Terms.';

  @override
  String get signupAgreeSuffix => '';

  @override
  String get signupButton => 'Create Account';

  @override
  String get signupHaveAccount => 'Already have an account? ';

  @override
  String get signupLogIn => 'Log In';

  @override
  String get errorEmailRequired => 'Please enter your email.';

  @override
  String get errorEmailInvalid => 'Please enter a valid email address.';

  @override
  String get errorPasswordRequired => 'Please enter your password.';

  @override
  String get errorPasswordShort => 'Password must be at least 6 characters.';

  @override
  String get errorNameRequired => 'Please enter your full name.';

  @override
  String get errorPhoneRequired => 'Please enter your phone number.';

  @override
  String get errorPhoneInvalid => 'Please enter a valid phone number.';

  @override
  String get errorConfirmRequired => 'Please confirm your password.';

  @override
  String get errorConfirmMismatch => 'Passwords do not match.';

  @override
  String get errorAgreeTerms => 'Please agree to the Terms to continue.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorInvalidCredentials => 'Email or password is incorrect.';

  @override
  String get errorAccountDisabled => 'This account has been disabled.';

  @override
  String get errorTooManyAttempts =>
      'Too many attempts. Please try again later.';

  @override
  String get errorNoInternet =>
      'Please check your internet connection and try again.';

  @override
  String get errorAccountExists => 'An account with this email already exists.';

  @override
  String get errorWeakPassword => 'Please choose a stronger password.';

  @override
  String get errorSignupUnavailable =>
      'Account creation is currently unavailable.';

  @override
  String get greetingMorning => 'Good morning,';

  @override
  String get greetingAfternoon => 'Good afternoon,';

  @override
  String get greetingEvening => 'Good evening,';

  @override
  String get safetyActive => 'Your digital safety is active.';

  @override
  String get protectedTitle => 'You\'re Protected';

  @override
  String get protectedBody =>
      'AmarGuard is ready to help you check suspicious interactions.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get seeAll => 'See All';

  @override
  String get serviceAnalyzeCallTitle => 'Analyze Call';

  @override
  String get serviceAnalyzeCallDesc => 'Detect scam & fraud';

  @override
  String get serviceCheckMessageTitle => 'Check Message';

  @override
  String get serviceCheckMessageDesc => 'Scan suspicious text';

  @override
  String get serviceCheckLinkTitle => 'Check Link';

  @override
  String get serviceCheckLinkDesc => 'Find unsafe websites';

  @override
  String get serviceScanScreenshotTitle => 'Scan Screenshot';

  @override
  String get serviceScanScreenshotDesc => 'Identify scams in images';

  @override
  String get serviceAnalyzeAudioTitle => 'Analyze Audio';

  @override
  String get serviceAnalyzeAudioDesc => 'Detect voice scams';

  @override
  String get serviceFamilySafetyTitle => 'Family Safety';

  @override
  String get serviceFamilySafetyDesc => 'Trusted contacts & safety';

  @override
  String get stayAlertTitle => 'Stay Alert!';

  @override
  String get stayAlertBody =>
      'Scams can happen in calls, messages, links and more.';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get riskHigh => 'High Risk';

  @override
  String get riskMedium => 'Medium Risk';

  @override
  String get riskLow => 'Low Risk';

  @override
  String get activityCallTitle => 'Unknown Call';

  @override
  String get activityScreenshotTitle => 'Screenshot Analysis';

  @override
  String get activityLinkTitle => 'Suspicious Link';

  @override
  String get navHome => 'Home';

  @override
  String get navProtect => 'Protect';

  @override
  String get navAnalyze => 'Analyze';

  @override
  String get navHistory => 'History';

  @override
  String get navProfile => 'Profile';

  @override
  String get protectTitle => 'Protect';

  @override
  String get protectTagline =>
      'Manage how AmarGuard keeps you safe across every interaction.';

  @override
  String get analyzeTitle => 'Analyze';

  @override
  String get analyzeTagline =>
      'Run a quick safety check on any call, message, link or file.';

  @override
  String get historyTitle => 'History';

  @override
  String get historyTagline =>
      'Review the analyses you have run and what AmarGuard found.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileTagline => 'Your account and AmarGuard preferences.';

  @override
  String get profileGuestBadge => 'Browsing as guest';

  @override
  String get profileActiveProtection => 'Active Protection';

  @override
  String get profileActiveProtectionGuest => 'Limited in guest mode';

  @override
  String get profileActiveProtectionUser => 'Enabled across your account';

  @override
  String get profileActivityHistory => 'Activity History';

  @override
  String get profileActivityHistorySubtitle => 'View recent analysis results';

  @override
  String get profileHelp => 'Help & Support';

  @override
  String get profileHelpSubtitle => 'Get answers about AmarGuard';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get profileSignedOut => 'Signed out';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageBangla => 'বাংলা';

  @override
  String get settingsLanguageSubtitle => 'Choose your preferred app language';

  @override
  String get placeholderSoonTitle => 'Coming together soon';

  @override
  String get placeholderSoonBody =>
      'This section is part of the AmarGuard roadmap and will be enabled once the next release is ready.';

  @override
  String get placeholderNotifyTitle => 'We\'ll let you know';

  @override
  String get placeholderNotifyBody =>
      'You will see updates here as soon as new protection features become available for your account.';

  @override
  String get maintenanceTitle => 'System Maintenance';

  @override
  String maintenanceBody(String service) {
    return '$service is temporarily unavailable while we complete system maintenance. Please try again later.';
  }

  @override
  String get maintenancePreparing =>
      'We\'re preparing this feature for a future release.';

  @override
  String get maintenanceGotIt => 'Got it';

  @override
  String get snackMenuTitle => 'Menu';

  @override
  String get snackMenuBody =>
      'The side menu is being prepared for the next AmarGuard release.';

  @override
  String get snackNotificationsTitle => 'Notifications';

  @override
  String get snackNotificationsBody =>
      'You have no new safety alerts right now.';

  @override
  String get firebaseUnavailableTitle => 'Firebase unavailable';

  @override
  String get firebaseUnavailableFallback =>
      'AmarGuard could not start. Please try again.';

  @override
  String get careTitle => 'Family Safety';

  @override
  String get careTagline =>
      'Stay connected with the people you trust. You stay in control at all times.';

  @override
  String get careBack => 'Back';

  @override
  String get careSharingActive => 'Sharing active';

  @override
  String get careSharingPaused => 'Sharing paused';

  @override
  String get careSharingStopped => 'Sharing stopped';

  @override
  String get careSharingNotConfigured => 'Not configured yet';

  @override
  String get carePermissionDisabled => 'Location permission disabled';

  @override
  String get careMyDevice => 'My Device';

  @override
  String get careDeviceIdentifier => 'Device ID';

  @override
  String get careCurrentLocationPermission => 'Location permission';

  @override
  String get careLastSync => 'Last successful sync';

  @override
  String get careBattery => 'Battery';

  @override
  String get careStartSharing => 'Start Sharing';

  @override
  String get carePauseSharing => 'Pause Sharing';

  @override
  String get careResumeSharing => 'Resume Sharing';

  @override
  String get careStopSharing => 'Stop Sharing';

  @override
  String get careConnectedMembers => 'Connected Family Members';

  @override
  String get careAddMember => 'Add Family Member';

  @override
  String get careViewMap => 'View Family Map';

  @override
  String get carePrivacySettings => 'Sharing & Privacy';

  @override
  String get careNoMembers => 'No family members connected yet';

  @override
  String get careNoMembersBody =>
      'Create an invitation and ask a trusted family member to connect.';

  @override
  String get careMemberFreshness => 'Last known location';

  @override
  String get careMemberFreshnessFresh => 'Recently updated';

  @override
  String get careMemberFreshnessStale => 'Last Known Location';

  @override
  String get careMemberFreshnessUnavailable => 'Offline or unavailable';

  @override
  String get careMemberFreshnessPaused => 'Sharing paused';

  @override
  String get careMemberFreshnessNotConnected => 'Not connected';

  @override
  String get careMemberFreshnessNotConfigured => 'Not yet configured';

  @override
  String get careMemberFreshnessPermissionDisabled => 'Permission disabled';

  @override
  String get careLastSeen => 'Last seen';

  @override
  String get careRelationship => 'Relationship';

  @override
  String get careBatteryLow => 'Battery Low';

  @override
  String get careBatteryCritical => 'Battery critically low';

  @override
  String get careCharging => 'Charging';

  @override
  String get careNotCharging => 'Not charging';

  @override
  String get careNever => 'Never';

  @override
  String get careJustNow => 'Just now';

  @override
  String careMinutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String careHoursAgo(int count) {
    return '$count h ago';
  }

  @override
  String careDaysAgo(int count) {
    return '$count d ago';
  }

  @override
  String get careFamilyMembersTitle => 'Family Members';

  @override
  String get careFamilyMembersSubtitle =>
      'People you have approved to view your location';

  @override
  String get careAddFamilyMemberTitle => 'Add Family Member';

  @override
  String get careAddFamilyMemberSubtitle =>
      'Invite someone you trust to see your location';

  @override
  String get careGenerateInvitation => 'Generate Invitation';

  @override
  String get careCopyInvitationLink => 'Copy Invitation Link';

  @override
  String get careShareInvitation => 'Share Invitation';

  @override
  String get careEnterInvitationCode => 'Enter Invitation Code';

  @override
  String get carePendingRequests => 'Pending Requests';

  @override
  String get careInvitationCodeLabel => 'Your invitation code';

  @override
  String careInvitationExpiresIn(int hours, int minutes) {
    return 'Expires in $hours h $minutes min';
  }

  @override
  String get careInvitationExpired => 'This invitation has expired.';

  @override
  String get careInvitationSafetyNote =>
      'Only share this code with someone you trust. The code itself never grants access to your location.';

  @override
  String get careInvitationCodeHint => 'Enter the code you received';

  @override
  String get careInvitationCodeEmpty => 'Please enter an invitation code.';

  @override
  String get careInvitationNotFound => 'No invitation found for that code.';

  @override
  String get careInvitationCopied => 'Invitation code copied.';

  @override
  String get careInvitationShared => 'Invitation shared.';

  @override
  String get careConnectionRequestTitle => 'Connection Request';

  @override
  String get careRequestedBy => 'Requested by';

  @override
  String get careIntendedConnection => 'Intended connection';

  @override
  String get careRequestedCapabilities => 'Requested access';

  @override
  String get carePrivacyDisclosure => 'Privacy disclosure';

  @override
  String get carePrivacyDisclosureBody =>
      'Approving this request lets the person view your shared device location, battery level and last update time. You can revoke this access at any time from Sharing & Privacy.';

  @override
  String get careApprove => 'Approve';

  @override
  String get careReject => 'Reject';

  @override
  String get careRequestApproved => 'Request approved.';

  @override
  String get careRequestRejected => 'Request rejected.';

  @override
  String get careJoinFamilyTitle => 'Join Family Safety';

  @override
  String get careJoinFamilySubtitle =>
      'You have been invited to connect on AmarGuard.';

  @override
  String get careAcceptInvitation => 'Accept Invitation';

  @override
  String get careDeclineInvitation => 'Decline';

  @override
  String get careInvitationAccepted =>
      'Request sent to the device owner. Location access stays blocked until they approve it.';

  @override
  String get careJoinPrivacyDisclosureBody =>
      'Sending this request does not give you location access. The device owner must review and approve it first. You can cancel later from Family Safety.';

  @override
  String get careSelfInvitation =>
      'You cannot join using your own invitation. Sign in with a different AmarGuard account.';

  @override
  String get careInvitationClosed => 'This invitation is no longer open.';

  @override
  String get careInvitationInvalid =>
      'This invitation is missing required device information.';

  @override
  String get careRequestAlreadyPending =>
      'A request is already waiting for the device owner\'s approval.';

  @override
  String get careRequestAlreadyProcessed =>
      'This invitation request was already processed.';

  @override
  String get careInvitationPermissionDenied =>
      'You do not have permission to send this request.';

  @override
  String get careWhatYouCanSee => 'What you can see';

  @override
  String get careCapabilityLocation => 'Live location with permission';

  @override
  String get careCapabilityBattery => 'Battery status';

  @override
  String get careCapabilityLastSeen => 'Last seen time';

  @override
  String get careCapabilityDevice => 'Device name';

  @override
  String get carePermissionTitle => 'Enable Location Sharing';

  @override
  String get carePermissionSubtitle =>
      'Review what AmarGuard needs before it can share your location.';

  @override
  String get carePermissionServiceOn => 'Location service is on';

  @override
  String get carePermissionServiceOff => 'Location service is off';

  @override
  String get carePermissionForeground => 'Allow while using the app';

  @override
  String get carePermissionBackground => 'Background access';

  @override
  String get carePermissionBackgroundBody =>
      'Android requires you to allow \"Allow all the time\" in system settings so the app can keep sharing while closed.';

  @override
  String get carePermissionBackgroundGranted => 'Background access granted';

  @override
  String get carePermissionBackgroundDenied => 'Background access not granted';

  @override
  String get carePermissionPrecision => 'Location precision';

  @override
  String get carePermissionPrecisionPrecise => 'Precise';

  @override
  String get carePermissionPrecisionApproximate => 'Approximate';

  @override
  String get carePermissionNotification => 'Foreground notification';

  @override
  String get carePermissionNotificationBody =>
      'A persistent notification is shown while sharing is active. It cannot be hidden.';

  @override
  String get carePermissionOpenSettings => 'Open system settings';

  @override
  String get carePermissionGrant => 'Grant permission';

  @override
  String get carePermissionCancel => 'Cancel';

  @override
  String get carePermissionContinue => 'Continue';

  @override
  String get carePermissionGranted => 'Location permission granted.';

  @override
  String get carePermissionDenied => 'Location permission was denied.';

  @override
  String get careMapTitle => 'Family Map';

  @override
  String get careMapRecenter => 'Recenter';

  @override
  String get careMapZoomIn => 'Zoom in';

  @override
  String get careMapZoomOut => 'Zoom out';

  @override
  String get careMapNoMembers => 'No approved family locations yet';

  @override
  String get careMapNoMembersBody =>
      'Once a family member approves a connection and enables sharing, their location appears here.';

  @override
  String get careMapTilesUnavailable =>
      'Map tiles are unavailable. Coordinates are still shown below.';

  @override
  String get careMapAttribution => '© OpenStreetMap contributors';

  @override
  String get careMapOpenInMaps => 'Open in Maps';

  @override
  String get careMapCoordinates => 'Coordinates';

  @override
  String get careMapAccuracy => 'Accuracy';

  @override
  String get careMapLastUpdate => 'Last update';

  @override
  String get careMemberDetailsTitle => 'Family Member Details';

  @override
  String get careDeviceNickname => 'Device name';

  @override
  String get careCoordinates => 'Coordinates';

  @override
  String get careCaptureTime => 'Location captured';

  @override
  String get careSyncTime => 'Last synchronized';

  @override
  String get careLiveStatus => 'Location status';

  @override
  String get careOpenInMaps => 'Open location in a map app';

  @override
  String get careNoLocationYet => 'No location received yet';

  @override
  String get careNoLocationYetBody =>
      'This member has not shared a location yet. Their last known location will appear here once they enable sharing.';

  @override
  String get carePrivacyTitle => 'Sharing & Privacy';

  @override
  String get carePrivacyWhoCanView => 'Who can view my location';

  @override
  String get carePrivacyWhoCanViewBody =>
      'Only the family members you explicitly approve can read your shared location.';

  @override
  String get carePrivacyActiveSessions => 'Active sharing sessions';

  @override
  String get carePrivacyDeviceControls => 'Device sharing controls';

  @override
  String get carePrivacyPermissionSettings => 'Permission settings';

  @override
  String get carePrivacyInformation => 'Privacy information';

  @override
  String get carePrivacyInformationBody =>
      'AmarGuard Care never collects location without your consent. Sharing is visible through a persistent Android notification, and you can pause, stop or revoke access at any time.';

  @override
  String get careRevokeAccess => 'Revoke Access';

  @override
  String get careRevokeConfirmTitle => 'Revoke access?';

  @override
  String get careRevokeConfirmBody =>
      'This family member will no longer be able to read your location. You can approve a new request later.';

  @override
  String get careRevokeDone => 'Access revoked.';

  @override
  String get careStopConfirmTitle => 'Stop sharing?';

  @override
  String get careStopConfirmBody =>
      'Your location will no longer be collected or sent. Approved members will keep the last location they already received.';

  @override
  String get careRemoveInvitation => 'Remove invitation';

  @override
  String get careRemoveInvitationConfirm => 'Remove this invitation?';

  @override
  String get careRemoveInvitationBody =>
      'Nobody with this code will be able to request a new connection.';

  @override
  String get careCancel => 'Cancel';

  @override
  String get careConfirm => 'Confirm';

  @override
  String get careGuestBlockedTitle => 'Sign in to use Family Safety';

  @override
  String get careGuestBlockedBody =>
      'Guest mode cannot create or approve family connections. Sign in with your AmarGuard account to share your location with trusted family members.';

  @override
  String get careSharingStarted => 'Location sharing started.';

  @override
  String get careSharingPausedMessage => 'Location sharing paused.';

  @override
  String get careSharingStoppedMessage => 'Location sharing stopped.';

  @override
  String get careSharingStartFailed =>
      'Could not start sharing. Check location permission and GPS.';

  @override
  String careLowBatteryAlert(String name, int percent) {
    return '$name has low battery ($percent%)';
  }

  @override
  String careCriticalBatteryAlert(String name, int percent) {
    return '$name battery is critically low ($percent%)';
  }

  @override
  String get careGpsOff => 'GPS is turned off on this device.';

  @override
  String get careRenameDevice => 'Rename device';

  @override
  String get careRenameDeviceHint => 'Device name';

  @override
  String get careSave => 'Save';

  @override
  String get careRelationshipParent => 'Parent';

  @override
  String get careRelationshipChild => 'Child';

  @override
  String get careRelationshipSpouse => 'Spouse';

  @override
  String get careRelationshipSibling => 'Sibling';

  @override
  String get careRelationshipGuardian => 'Guardian';

  @override
  String get careRelationshipCaregiver => 'Caregiver';

  @override
  String get careRelationshipFriend => 'Friend';

  @override
  String get careRelationshipOther => 'Other';

  @override
  String careInvitationOwner(String name) {
    return 'Invited by $name';
  }

  @override
  String get careRequestStatusPending => 'Pending';

  @override
  String get careRequestStatusApproved => 'Approved';

  @override
  String get careRequestStatusRejected => 'Rejected';

  @override
  String careWatchedBy(int count) {
    return 'You can view $count family member';
  }

  @override
  String careWatchedByPlural(int count) {
    return 'You can view $count family members';
  }

  @override
  String careSharingTo(int count) {
    return 'Sharing with $count approved member';
  }

  @override
  String careSharingToPlural(int count) {
    return 'Sharing with $count approved members';
  }

  @override
  String get careLocationSharing => 'Location sharing';

  @override
  String get careLoading => 'Loading...';

  @override
  String get careRetry => 'Retry';

  @override
  String get careOpenSettings => 'Open settings';

  @override
  String careMemberSince(String date) {
    return 'Connected since $date';
  }
}
