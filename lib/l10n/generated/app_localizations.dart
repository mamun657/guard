import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AmarGuard'**
  String get appTitle;

  /// Brand tagline displayed in caps
  ///
  /// In en, this message translates to:
  /// **'UNDERSTAND BEFORE YOU TRUST.'**
  String get brandTagline;

  /// No description provided for @splashCredit.
  ///
  /// In en, this message translates to:
  /// **'by BinaryPulse'**
  String get splashCredit;

  /// Onboarding page 1 title
  ///
  /// In en, this message translates to:
  /// **'Stay safer in every\ndigital interaction.'**
  String get onboardingTitle1;

  /// Onboarding page 1 subtitle
  ///
  /// In en, this message translates to:
  /// **'Detect, understand and respond to risky\ncalls, messages, links and screenshots.'**
  String get onboardingSubtitle1;

  /// Onboarding page 2 title
  ///
  /// In en, this message translates to:
  /// **'Scams don\'t always\nstart with a link.'**
  String get onboardingTitle2;

  /// Onboarding page 2 subtitle
  ///
  /// In en, this message translates to:
  /// **'Sometimes, they start with\na conversation.'**
  String get onboardingSubtitle2;

  /// Onboarding page 3 title
  ///
  /// In en, this message translates to:
  /// **'Know why something\nfeels risky.'**
  String get onboardingTitle3;

  /// Onboarding page 3 subtitle
  ///
  /// In en, this message translates to:
  /// **'AI analyzes the whole interaction\nand explains the risk.'**
  String get onboardingSubtitle3;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// Sample scam chat bubble 1
  ///
  /// In en, this message translates to:
  /// **'You\'ve been selected\nfor a special offer!'**
  String get scamBubble1;

  /// No description provided for @scamBubble2.
  ///
  /// In en, this message translates to:
  /// **'Pay now to confirm.'**
  String get scamBubble2;

  /// No description provided for @scamBubble3.
  ///
  /// In en, this message translates to:
  /// **'Don\'t tell anyone.'**
  String get scamBubble3;

  /// No description provided for @scamBubble4.
  ///
  /// In en, this message translates to:
  /// **'Share your OTP.'**
  String get scamBubble4;

  /// No description provided for @pipelineStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get pipelineStep1Title;

  /// No description provided for @pipelineStep1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Voice to Text'**
  String get pipelineStep1Subtitle;

  /// No description provided for @pipelineStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Context Analysis'**
  String get pipelineStep2Title;

  /// No description provided for @pipelineStep2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Find risk signals'**
  String get pipelineStep2Subtitle;

  /// No description provided for @pipelineStep3Title.
  ///
  /// In en, this message translates to:
  /// **'AI Risk Detection'**
  String get pipelineStep3Title;

  /// No description provided for @pipelineStep3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'XGBoost + SHAP'**
  String get pipelineStep3Subtitle;

  /// No description provided for @pipelineStep4Title.
  ///
  /// In en, this message translates to:
  /// **'Clear Explanation'**
  String get pipelineStep4Title;

  /// No description provided for @pipelineStep4Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Why is it risky?'**
  String get pipelineStep4Subtitle;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcome;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to keep a safer digital life.'**
  String get loginSubtitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordHint;

  /// No description provided for @loginKeepMe.
  ///
  /// In en, this message translates to:
  /// **'Keep me signed in'**
  String get loginKeepMe;

  /// No description provided for @loginForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginForgot;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginButton;

  /// No description provided for @loginContinueAs.
  ///
  /// In en, this message translates to:
  /// **'or continue as'**
  String get loginContinueAs;

  /// No description provided for @loginGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get loginGuest;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get loginNoAccount;

  /// No description provided for @loginSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get loginSignUp;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your\nSafety Account'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join AmarGuard and stay protected.'**
  String get signupSubtitle;

  /// No description provided for @signupNameHint.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get signupNameHint;

  /// No description provided for @signupEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get signupEmailHint;

  /// No description provided for @signupPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get signupPhoneHint;

  /// No description provided for @signupPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signupPasswordHint;

  /// No description provided for @signupConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get signupConfirmHint;

  /// No description provided for @signupAgreePrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get signupAgreePrefix;

  /// No description provided for @signupAgreePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get signupAgreePrivacy;

  /// No description provided for @signupAgreeAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get signupAgreeAnd;

  /// No description provided for @signupAgreeTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms.'**
  String get signupAgreeTerms;

  /// No description provided for @signupAgreeSuffix.
  ///
  /// In en, this message translates to:
  /// **''**
  String get signupAgreeSuffix;

  /// No description provided for @signupButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupButton;

  /// No description provided for @signupHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get signupHaveAccount;

  /// No description provided for @signupLogIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get signupLogIn;

  /// No description provided for @errorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get errorEmailRequired;

  /// No description provided for @errorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get errorEmailInvalid;

  /// No description provided for @errorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get errorPasswordRequired;

  /// No description provided for @errorPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get errorPasswordShort;

  /// No description provided for @errorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name.'**
  String get errorNameRequired;

  /// No description provided for @errorPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number.'**
  String get errorPhoneRequired;

  /// No description provided for @errorPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get errorPhoneInvalid;

  /// No description provided for @errorConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password.'**
  String get errorConfirmRequired;

  /// No description provided for @errorConfirmMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get errorConfirmMismatch;

  /// No description provided for @errorAgreeTerms.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms to continue.'**
  String get errorAgreeTerms;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get errorAccountDisabled;

  /// No description provided for @errorTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get errorTooManyAttempts;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get errorNoInternet;

  /// No description provided for @errorAccountExists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get errorAccountExists;

  /// No description provided for @errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Please choose a stronger password.'**
  String get errorWeakPassword;

  /// No description provided for @errorSignupUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Account creation is currently unavailable.'**
  String get errorSignupUnavailable;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon,'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening,'**
  String get greetingEvening;

  /// No description provided for @safetyActive.
  ///
  /// In en, this message translates to:
  /// **'Your digital safety is active.'**
  String get safetyActive;

  /// No description provided for @protectedTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re Protected'**
  String get protectedTitle;

  /// No description provided for @protectedBody.
  ///
  /// In en, this message translates to:
  /// **'AmarGuard is ready to help you check suspicious interactions.'**
  String get protectedBody;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @serviceAnalyzeCallTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze Call'**
  String get serviceAnalyzeCallTitle;

  /// No description provided for @serviceAnalyzeCallDesc.
  ///
  /// In en, this message translates to:
  /// **'Detect scam & fraud'**
  String get serviceAnalyzeCallDesc;

  /// No description provided for @serviceCheckMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Check Message'**
  String get serviceCheckMessageTitle;

  /// No description provided for @serviceCheckMessageDesc.
  ///
  /// In en, this message translates to:
  /// **'Scan suspicious text'**
  String get serviceCheckMessageDesc;

  /// No description provided for @serviceCheckLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Check Link'**
  String get serviceCheckLinkTitle;

  /// No description provided for @serviceCheckLinkDesc.
  ///
  /// In en, this message translates to:
  /// **'Find unsafe websites'**
  String get serviceCheckLinkDesc;

  /// No description provided for @serviceScanScreenshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Screenshot'**
  String get serviceScanScreenshotTitle;

  /// No description provided for @serviceScanScreenshotDesc.
  ///
  /// In en, this message translates to:
  /// **'Identify scams in images'**
  String get serviceScanScreenshotDesc;

  /// No description provided for @serviceAnalyzeAudioTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze Audio'**
  String get serviceAnalyzeAudioTitle;

  /// No description provided for @serviceAnalyzeAudioDesc.
  ///
  /// In en, this message translates to:
  /// **'Detect voice scams'**
  String get serviceAnalyzeAudioDesc;

  /// No description provided for @serviceFamilySafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Safety'**
  String get serviceFamilySafetyTitle;

  /// No description provided for @serviceFamilySafetyDesc.
  ///
  /// In en, this message translates to:
  /// **'Trusted contacts & safety'**
  String get serviceFamilySafetyDesc;

  /// No description provided for @stayAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay Alert!'**
  String get stayAlertTitle;

  /// No description provided for @stayAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Scams can happen in calls, messages, links and more.'**
  String get stayAlertBody;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @riskHigh.
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get riskHigh;

  /// No description provided for @riskMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium Risk'**
  String get riskMedium;

  /// No description provided for @riskLow.
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get riskLow;

  /// No description provided for @activityCallTitle.
  ///
  /// In en, this message translates to:
  /// **'Unknown Call'**
  String get activityCallTitle;

  /// No description provided for @activityScreenshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Screenshot Analysis'**
  String get activityScreenshotTitle;

  /// No description provided for @activityLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Suspicious Link'**
  String get activityLinkTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProtect.
  ///
  /// In en, this message translates to:
  /// **'Protect'**
  String get navProtect;

  /// No description provided for @navAnalyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get navAnalyze;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @protectTitle.
  ///
  /// In en, this message translates to:
  /// **'Protect'**
  String get protectTitle;

  /// No description provided for @protectTagline.
  ///
  /// In en, this message translates to:
  /// **'Manage how AmarGuard keeps you safe across every interaction.'**
  String get protectTagline;

  /// No description provided for @analyzeTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyzeTitle;

  /// No description provided for @analyzeTagline.
  ///
  /// In en, this message translates to:
  /// **'Run a quick safety check on any call, message, link or file.'**
  String get analyzeTagline;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyTagline.
  ///
  /// In en, this message translates to:
  /// **'Review the analyses you have run and what AmarGuard found.'**
  String get historyTagline;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileTagline.
  ///
  /// In en, this message translates to:
  /// **'Your account and AmarGuard preferences.'**
  String get profileTagline;

  /// No description provided for @profileGuestBadge.
  ///
  /// In en, this message translates to:
  /// **'Browsing as guest'**
  String get profileGuestBadge;

  /// No description provided for @profileActiveProtection.
  ///
  /// In en, this message translates to:
  /// **'Active Protection'**
  String get profileActiveProtection;

  /// No description provided for @profileActiveProtectionGuest.
  ///
  /// In en, this message translates to:
  /// **'Limited in guest mode'**
  String get profileActiveProtectionGuest;

  /// No description provided for @profileActiveProtectionUser.
  ///
  /// In en, this message translates to:
  /// **'Enabled across your account'**
  String get profileActiveProtectionUser;

  /// No description provided for @profileActivityHistory.
  ///
  /// In en, this message translates to:
  /// **'Activity History'**
  String get profileActivityHistory;

  /// No description provided for @profileActivityHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'View recent analysis results'**
  String get profileActivityHistorySubtitle;

  /// No description provided for @profileHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get profileHelp;

  /// No description provided for @profileHelpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get answers about AmarGuard'**
  String get profileHelpSubtitle;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// No description provided for @profileSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Signed out'**
  String get profileSignedOut;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageBangla.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get settingsLanguageBangla;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred app language'**
  String get settingsLanguageSubtitle;

  /// No description provided for @placeholderSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming together soon'**
  String get placeholderSoonTitle;

  /// No description provided for @placeholderSoonBody.
  ///
  /// In en, this message translates to:
  /// **'This section is part of the AmarGuard roadmap and will be enabled once the next release is ready.'**
  String get placeholderSoonBody;

  /// No description provided for @placeholderNotifyTitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll let you know'**
  String get placeholderNotifyTitle;

  /// No description provided for @placeholderNotifyBody.
  ///
  /// In en, this message translates to:
  /// **'You will see updates here as soon as new protection features become available for your account.'**
  String get placeholderNotifyBody;

  /// No description provided for @maintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'System Maintenance'**
  String get maintenanceTitle;

  /// No description provided for @maintenanceBody.
  ///
  /// In en, this message translates to:
  /// **'{service} is temporarily unavailable while we complete system maintenance. Please try again later.'**
  String maintenanceBody(String service);

  /// No description provided for @maintenancePreparing.
  ///
  /// In en, this message translates to:
  /// **'We\'re preparing this feature for a future release.'**
  String get maintenancePreparing;

  /// No description provided for @maintenanceGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get maintenanceGotIt;

  /// No description provided for @snackMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get snackMenuTitle;

  /// No description provided for @snackMenuBody.
  ///
  /// In en, this message translates to:
  /// **'The side menu is being prepared for the next AmarGuard release.'**
  String get snackMenuBody;

  /// No description provided for @snackNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get snackNotificationsTitle;

  /// No description provided for @snackNotificationsBody.
  ///
  /// In en, this message translates to:
  /// **'You have no new safety alerts right now.'**
  String get snackNotificationsBody;

  /// No description provided for @firebaseUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Firebase unavailable'**
  String get firebaseUnavailableTitle;

  /// No description provided for @firebaseUnavailableFallback.
  ///
  /// In en, this message translates to:
  /// **'AmarGuard could not start. Please try again.'**
  String get firebaseUnavailableFallback;

  /// No description provided for @careTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Safety'**
  String get careTitle;

  /// No description provided for @careTagline.
  ///
  /// In en, this message translates to:
  /// **'Stay connected with the people you trust. You stay in control at all times.'**
  String get careTagline;

  /// No description provided for @careBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get careBack;

  /// No description provided for @careSharingActive.
  ///
  /// In en, this message translates to:
  /// **'Sharing active'**
  String get careSharingActive;

  /// No description provided for @careSharingPaused.
  ///
  /// In en, this message translates to:
  /// **'Sharing paused'**
  String get careSharingPaused;

  /// No description provided for @careSharingStopped.
  ///
  /// In en, this message translates to:
  /// **'Sharing stopped'**
  String get careSharingStopped;

  /// No description provided for @careSharingNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not configured yet'**
  String get careSharingNotConfigured;

  /// No description provided for @carePermissionDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location permission disabled'**
  String get carePermissionDisabled;

  /// No description provided for @careMyDevice.
  ///
  /// In en, this message translates to:
  /// **'My Device'**
  String get careMyDevice;

  /// No description provided for @careDeviceIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Device ID'**
  String get careDeviceIdentifier;

  /// No description provided for @careCurrentLocationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location permission'**
  String get careCurrentLocationPermission;

  /// No description provided for @careLastSync.
  ///
  /// In en, this message translates to:
  /// **'Last successful sync'**
  String get careLastSync;

  /// No description provided for @careBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get careBattery;

  /// No description provided for @careStartSharing.
  ///
  /// In en, this message translates to:
  /// **'Start Sharing'**
  String get careStartSharing;

  /// No description provided for @carePauseSharing.
  ///
  /// In en, this message translates to:
  /// **'Pause Sharing'**
  String get carePauseSharing;

  /// No description provided for @careResumeSharing.
  ///
  /// In en, this message translates to:
  /// **'Resume Sharing'**
  String get careResumeSharing;

  /// No description provided for @careStopSharing.
  ///
  /// In en, this message translates to:
  /// **'Stop Sharing'**
  String get careStopSharing;

  /// No description provided for @careConnectedMembers.
  ///
  /// In en, this message translates to:
  /// **'Connected Family Members'**
  String get careConnectedMembers;

  /// No description provided for @careAddMember.
  ///
  /// In en, this message translates to:
  /// **'Add Family Member'**
  String get careAddMember;

  /// No description provided for @careViewMap.
  ///
  /// In en, this message translates to:
  /// **'View Family Map'**
  String get careViewMap;

  /// No description provided for @carePrivacySettings.
  ///
  /// In en, this message translates to:
  /// **'Sharing & Privacy'**
  String get carePrivacySettings;

  /// No description provided for @careNoMembers.
  ///
  /// In en, this message translates to:
  /// **'No family members connected yet'**
  String get careNoMembers;

  /// No description provided for @careNoMembersBody.
  ///
  /// In en, this message translates to:
  /// **'Create an invitation and ask a trusted family member to connect.'**
  String get careNoMembersBody;

  /// No description provided for @careMemberFreshness.
  ///
  /// In en, this message translates to:
  /// **'Last known location'**
  String get careMemberFreshness;

  /// No description provided for @careMemberFreshnessFresh.
  ///
  /// In en, this message translates to:
  /// **'Recently updated'**
  String get careMemberFreshnessFresh;

  /// No description provided for @careMemberFreshnessStale.
  ///
  /// In en, this message translates to:
  /// **'Last Known Location'**
  String get careMemberFreshnessStale;

  /// No description provided for @careMemberFreshnessUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Offline or unavailable'**
  String get careMemberFreshnessUnavailable;

  /// No description provided for @careMemberFreshnessPaused.
  ///
  /// In en, this message translates to:
  /// **'Sharing paused'**
  String get careMemberFreshnessPaused;

  /// No description provided for @careMemberFreshnessNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get careMemberFreshnessNotConnected;

  /// No description provided for @careMemberFreshnessNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not yet configured'**
  String get careMemberFreshnessNotConfigured;

  /// No description provided for @careMemberFreshnessPermissionDisabled.
  ///
  /// In en, this message translates to:
  /// **'Permission disabled'**
  String get careMemberFreshnessPermissionDisabled;

  /// No description provided for @careLastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get careLastSeen;

  /// No description provided for @careRelationship.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get careRelationship;

  /// No description provided for @careBatteryLow.
  ///
  /// In en, this message translates to:
  /// **'Battery Low'**
  String get careBatteryLow;

  /// No description provided for @careBatteryCritical.
  ///
  /// In en, this message translates to:
  /// **'Battery critically low'**
  String get careBatteryCritical;

  /// No description provided for @careCharging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get careCharging;

  /// No description provided for @careNotCharging.
  ///
  /// In en, this message translates to:
  /// **'Not charging'**
  String get careNotCharging;

  /// No description provided for @careNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get careNever;

  /// No description provided for @careJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get careJustNow;

  /// No description provided for @careMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String careMinutesAgo(int count);

  /// No description provided for @careHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} h ago'**
  String careHoursAgo(int count);

  /// No description provided for @careDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} d ago'**
  String careDaysAgo(int count);

  /// No description provided for @careFamilyMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Members'**
  String get careFamilyMembersTitle;

  /// No description provided for @careFamilyMembersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'People you have approved to view your location'**
  String get careFamilyMembersSubtitle;

  /// No description provided for @careAddFamilyMemberTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Family Member'**
  String get careAddFamilyMemberTitle;

  /// No description provided for @careAddFamilyMemberSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invite someone you trust to see your location'**
  String get careAddFamilyMemberSubtitle;

  /// No description provided for @careGenerateInvitation.
  ///
  /// In en, this message translates to:
  /// **'Generate Invitation'**
  String get careGenerateInvitation;

  /// No description provided for @careCopyInvitationLink.
  ///
  /// In en, this message translates to:
  /// **'Copy Invitation Link'**
  String get careCopyInvitationLink;

  /// No description provided for @careShareInvitation.
  ///
  /// In en, this message translates to:
  /// **'Share Invitation'**
  String get careShareInvitation;

  /// No description provided for @careEnterInvitationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Invitation Code'**
  String get careEnterInvitationCode;

  /// No description provided for @carePendingRequests.
  ///
  /// In en, this message translates to:
  /// **'Pending Requests'**
  String get carePendingRequests;

  /// No description provided for @careInvitationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Your invitation code'**
  String get careInvitationCodeLabel;

  /// No description provided for @careInvitationExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Expires in {hours} h {minutes} min'**
  String careInvitationExpiresIn(int hours, int minutes);

  /// No description provided for @careInvitationExpired.
  ///
  /// In en, this message translates to:
  /// **'This invitation has expired.'**
  String get careInvitationExpired;

  /// No description provided for @careInvitationSafetyNote.
  ///
  /// In en, this message translates to:
  /// **'Only share this code with someone you trust. The code itself never grants access to your location.'**
  String get careInvitationSafetyNote;

  /// No description provided for @careInvitationCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the code you received'**
  String get careInvitationCodeHint;

  /// No description provided for @careInvitationCodeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an invitation code.'**
  String get careInvitationCodeEmpty;

  /// No description provided for @careInvitationNotFound.
  ///
  /// In en, this message translates to:
  /// **'No invitation found for that code.'**
  String get careInvitationNotFound;

  /// No description provided for @careInvitationCopied.
  ///
  /// In en, this message translates to:
  /// **'Invitation code copied.'**
  String get careInvitationCopied;

  /// No description provided for @careInvitationShared.
  ///
  /// In en, this message translates to:
  /// **'Invitation shared.'**
  String get careInvitationShared;

  /// No description provided for @careConnectionRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Connection Request'**
  String get careConnectionRequestTitle;

  /// No description provided for @careRequestedBy.
  ///
  /// In en, this message translates to:
  /// **'Requested by'**
  String get careRequestedBy;

  /// No description provided for @careIntendedConnection.
  ///
  /// In en, this message translates to:
  /// **'Intended connection'**
  String get careIntendedConnection;

  /// No description provided for @careRequestedCapabilities.
  ///
  /// In en, this message translates to:
  /// **'Requested access'**
  String get careRequestedCapabilities;

  /// No description provided for @carePrivacyDisclosure.
  ///
  /// In en, this message translates to:
  /// **'Privacy disclosure'**
  String get carePrivacyDisclosure;

  /// No description provided for @carePrivacyDisclosureBody.
  ///
  /// In en, this message translates to:
  /// **'Approving this request lets the person view your shared device location, battery level and last update time. You can revoke this access at any time from Sharing & Privacy.'**
  String get carePrivacyDisclosureBody;

  /// No description provided for @careApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get careApprove;

  /// No description provided for @careReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get careReject;

  /// No description provided for @careRequestApproved.
  ///
  /// In en, this message translates to:
  /// **'Request approved.'**
  String get careRequestApproved;

  /// No description provided for @careRequestRejected.
  ///
  /// In en, this message translates to:
  /// **'Request rejected.'**
  String get careRequestRejected;

  /// No description provided for @careJoinFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Family Safety'**
  String get careJoinFamilyTitle;

  /// No description provided for @careJoinFamilySubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have been invited to connect on AmarGuard.'**
  String get careJoinFamilySubtitle;

  /// No description provided for @careAcceptInvitation.
  ///
  /// In en, this message translates to:
  /// **'Accept Invitation'**
  String get careAcceptInvitation;

  /// No description provided for @careDeclineInvitation.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get careDeclineInvitation;

  /// No description provided for @careInvitationAccepted.
  ///
  /// In en, this message translates to:
  /// **'Request sent to the device owner. Location access stays blocked until they approve it.'**
  String get careInvitationAccepted;

  /// No description provided for @careJoinPrivacyDisclosureBody.
  ///
  /// In en, this message translates to:
  /// **'Sending this request does not give you location access. The device owner must review and approve it first. You can cancel later from Family Safety.'**
  String get careJoinPrivacyDisclosureBody;

  /// No description provided for @careSelfInvitation.
  ///
  /// In en, this message translates to:
  /// **'You cannot join using your own invitation. Sign in with a different AmarGuard account.'**
  String get careSelfInvitation;

  /// No description provided for @careInvitationClosed.
  ///
  /// In en, this message translates to:
  /// **'This invitation is no longer open.'**
  String get careInvitationClosed;

  /// No description provided for @careInvitationInvalid.
  ///
  /// In en, this message translates to:
  /// **'This invitation is missing required device information.'**
  String get careInvitationInvalid;

  /// No description provided for @careRequestAlreadyPending.
  ///
  /// In en, this message translates to:
  /// **'A request is already waiting for the device owner\'s approval.'**
  String get careRequestAlreadyPending;

  /// No description provided for @careRequestAlreadyProcessed.
  ///
  /// In en, this message translates to:
  /// **'This invitation request was already processed.'**
  String get careRequestAlreadyProcessed;

  /// No description provided for @careInvitationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to send this request.'**
  String get careInvitationPermissionDenied;

  /// No description provided for @careWhatYouCanSee.
  ///
  /// In en, this message translates to:
  /// **'What you can see'**
  String get careWhatYouCanSee;

  /// No description provided for @careCapabilityLocation.
  ///
  /// In en, this message translates to:
  /// **'Live location with permission'**
  String get careCapabilityLocation;

  /// No description provided for @careCapabilityBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery status'**
  String get careCapabilityBattery;

  /// No description provided for @careCapabilityLastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last seen time'**
  String get careCapabilityLastSeen;

  /// No description provided for @careCapabilityDevice.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get careCapabilityDevice;

  /// No description provided for @carePermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Location Sharing'**
  String get carePermissionTitle;

  /// No description provided for @carePermissionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review what AmarGuard needs before it can share your location.'**
  String get carePermissionSubtitle;

  /// No description provided for @carePermissionServiceOn.
  ///
  /// In en, this message translates to:
  /// **'Location service is on'**
  String get carePermissionServiceOn;

  /// No description provided for @carePermissionServiceOff.
  ///
  /// In en, this message translates to:
  /// **'Location service is off'**
  String get carePermissionServiceOff;

  /// No description provided for @carePermissionForeground.
  ///
  /// In en, this message translates to:
  /// **'Allow while using the app'**
  String get carePermissionForeground;

  /// No description provided for @carePermissionBackground.
  ///
  /// In en, this message translates to:
  /// **'Background access'**
  String get carePermissionBackground;

  /// No description provided for @carePermissionBackgroundBody.
  ///
  /// In en, this message translates to:
  /// **'Android requires you to allow \"Allow all the time\" in system settings so the app can keep sharing while closed.'**
  String get carePermissionBackgroundBody;

  /// No description provided for @carePermissionBackgroundGranted.
  ///
  /// In en, this message translates to:
  /// **'Background access granted'**
  String get carePermissionBackgroundGranted;

  /// No description provided for @carePermissionBackgroundDenied.
  ///
  /// In en, this message translates to:
  /// **'Background access not granted'**
  String get carePermissionBackgroundDenied;

  /// No description provided for @carePermissionPrecision.
  ///
  /// In en, this message translates to:
  /// **'Location precision'**
  String get carePermissionPrecision;

  /// No description provided for @carePermissionPrecisionPrecise.
  ///
  /// In en, this message translates to:
  /// **'Precise'**
  String get carePermissionPrecisionPrecise;

  /// No description provided for @carePermissionPrecisionApproximate.
  ///
  /// In en, this message translates to:
  /// **'Approximate'**
  String get carePermissionPrecisionApproximate;

  /// No description provided for @carePermissionNotification.
  ///
  /// In en, this message translates to:
  /// **'Foreground notification'**
  String get carePermissionNotification;

  /// No description provided for @carePermissionNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'A persistent notification is shown while sharing is active. It cannot be hidden.'**
  String get carePermissionNotificationBody;

  /// No description provided for @carePermissionOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open system settings'**
  String get carePermissionOpenSettings;

  /// No description provided for @carePermissionGrant.
  ///
  /// In en, this message translates to:
  /// **'Grant permission'**
  String get carePermissionGrant;

  /// No description provided for @carePermissionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get carePermissionCancel;

  /// No description provided for @carePermissionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get carePermissionContinue;

  /// No description provided for @carePermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Location permission granted.'**
  String get carePermissionGranted;

  /// No description provided for @carePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission was denied.'**
  String get carePermissionDenied;

  /// No description provided for @careMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Map'**
  String get careMapTitle;

  /// No description provided for @careMapRecenter.
  ///
  /// In en, this message translates to:
  /// **'Recenter'**
  String get careMapRecenter;

  /// No description provided for @careMapZoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get careMapZoomIn;

  /// No description provided for @careMapZoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get careMapZoomOut;

  /// No description provided for @careMapNoMembers.
  ///
  /// In en, this message translates to:
  /// **'No approved family locations yet'**
  String get careMapNoMembers;

  /// No description provided for @careMapNoMembersBody.
  ///
  /// In en, this message translates to:
  /// **'Once a family member approves a connection and enables sharing, their location appears here.'**
  String get careMapNoMembersBody;

  /// No description provided for @careMapTilesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Map tiles are unavailable. Coordinates are still shown below.'**
  String get careMapTilesUnavailable;

  /// No description provided for @careMapAttribution.
  ///
  /// In en, this message translates to:
  /// **'© OpenStreetMap contributors'**
  String get careMapAttribution;

  /// No description provided for @careMapOpenInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get careMapOpenInMaps;

  /// No description provided for @careMapCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get careMapCoordinates;

  /// No description provided for @careMapAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get careMapAccuracy;

  /// No description provided for @careMapLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update'**
  String get careMapLastUpdate;

  /// No description provided for @careMemberDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Member Details'**
  String get careMemberDetailsTitle;

  /// No description provided for @careDeviceNickname.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get careDeviceNickname;

  /// No description provided for @careCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get careCoordinates;

  /// No description provided for @careCaptureTime.
  ///
  /// In en, this message translates to:
  /// **'Location captured'**
  String get careCaptureTime;

  /// No description provided for @careSyncTime.
  ///
  /// In en, this message translates to:
  /// **'Last synchronized'**
  String get careSyncTime;

  /// No description provided for @careLiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Location status'**
  String get careLiveStatus;

  /// No description provided for @careOpenInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open location in a map app'**
  String get careOpenInMaps;

  /// No description provided for @careNoLocationYet.
  ///
  /// In en, this message translates to:
  /// **'No location received yet'**
  String get careNoLocationYet;

  /// No description provided for @careNoLocationYetBody.
  ///
  /// In en, this message translates to:
  /// **'This member has not shared a location yet. Their last known location will appear here once they enable sharing.'**
  String get careNoLocationYetBody;

  /// No description provided for @carePrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Sharing & Privacy'**
  String get carePrivacyTitle;

  /// No description provided for @carePrivacyWhoCanView.
  ///
  /// In en, this message translates to:
  /// **'Who can view my location'**
  String get carePrivacyWhoCanView;

  /// No description provided for @carePrivacyWhoCanViewBody.
  ///
  /// In en, this message translates to:
  /// **'Only the family members you explicitly approve can read your shared location.'**
  String get carePrivacyWhoCanViewBody;

  /// No description provided for @carePrivacyActiveSessions.
  ///
  /// In en, this message translates to:
  /// **'Active sharing sessions'**
  String get carePrivacyActiveSessions;

  /// No description provided for @carePrivacyDeviceControls.
  ///
  /// In en, this message translates to:
  /// **'Device sharing controls'**
  String get carePrivacyDeviceControls;

  /// No description provided for @carePrivacyPermissionSettings.
  ///
  /// In en, this message translates to:
  /// **'Permission settings'**
  String get carePrivacyPermissionSettings;

  /// No description provided for @carePrivacyInformation.
  ///
  /// In en, this message translates to:
  /// **'Privacy information'**
  String get carePrivacyInformation;

  /// No description provided for @carePrivacyInformationBody.
  ///
  /// In en, this message translates to:
  /// **'AmarGuard Care never collects location without your consent. Sharing is visible through a persistent Android notification, and you can pause, stop or revoke access at any time.'**
  String get carePrivacyInformationBody;

  /// No description provided for @careRevokeAccess.
  ///
  /// In en, this message translates to:
  /// **'Revoke Access'**
  String get careRevokeAccess;

  /// No description provided for @careRevokeConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Revoke access?'**
  String get careRevokeConfirmTitle;

  /// No description provided for @careRevokeConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This family member will no longer be able to read your location. You can approve a new request later.'**
  String get careRevokeConfirmBody;

  /// No description provided for @careRevokeDone.
  ///
  /// In en, this message translates to:
  /// **'Access revoked.'**
  String get careRevokeDone;

  /// No description provided for @careStopConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Stop sharing?'**
  String get careStopConfirmTitle;

  /// No description provided for @careStopConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Your location will no longer be collected or sent. Approved members will keep the last location they already received.'**
  String get careStopConfirmBody;

  /// No description provided for @careRemoveInvitation.
  ///
  /// In en, this message translates to:
  /// **'Remove invitation'**
  String get careRemoveInvitation;

  /// No description provided for @careRemoveInvitationConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove this invitation?'**
  String get careRemoveInvitationConfirm;

  /// No description provided for @careRemoveInvitationBody.
  ///
  /// In en, this message translates to:
  /// **'Nobody with this code will be able to request a new connection.'**
  String get careRemoveInvitationBody;

  /// No description provided for @careCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get careCancel;

  /// No description provided for @careConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get careConfirm;

  /// No description provided for @careGuestBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to use Family Safety'**
  String get careGuestBlockedTitle;

  /// No description provided for @careGuestBlockedBody.
  ///
  /// In en, this message translates to:
  /// **'Guest mode cannot create or approve family connections. Sign in with your AmarGuard account to share your location with trusted family members.'**
  String get careGuestBlockedBody;

  /// No description provided for @careSharingStarted.
  ///
  /// In en, this message translates to:
  /// **'Location sharing started.'**
  String get careSharingStarted;

  /// No description provided for @careSharingPausedMessage.
  ///
  /// In en, this message translates to:
  /// **'Location sharing paused.'**
  String get careSharingPausedMessage;

  /// No description provided for @careSharingStoppedMessage.
  ///
  /// In en, this message translates to:
  /// **'Location sharing stopped.'**
  String get careSharingStoppedMessage;

  /// No description provided for @careSharingStartFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not start sharing. Check location permission and GPS.'**
  String get careSharingStartFailed;

  /// No description provided for @careLowBatteryAlert.
  ///
  /// In en, this message translates to:
  /// **'{name} has low battery ({percent}%)'**
  String careLowBatteryAlert(String name, int percent);

  /// No description provided for @careCriticalBatteryAlert.
  ///
  /// In en, this message translates to:
  /// **'{name} battery is critically low ({percent}%)'**
  String careCriticalBatteryAlert(String name, int percent);

  /// No description provided for @careGpsOff.
  ///
  /// In en, this message translates to:
  /// **'GPS is turned off on this device.'**
  String get careGpsOff;

  /// No description provided for @careRenameDevice.
  ///
  /// In en, this message translates to:
  /// **'Rename device'**
  String get careRenameDevice;

  /// No description provided for @careRenameDeviceHint.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get careRenameDeviceHint;

  /// No description provided for @careSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get careSave;

  /// No description provided for @careRelationshipParent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get careRelationshipParent;

  /// No description provided for @careRelationshipChild.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get careRelationshipChild;

  /// No description provided for @careRelationshipSpouse.
  ///
  /// In en, this message translates to:
  /// **'Spouse'**
  String get careRelationshipSpouse;

  /// No description provided for @careRelationshipSibling.
  ///
  /// In en, this message translates to:
  /// **'Sibling'**
  String get careRelationshipSibling;

  /// No description provided for @careRelationshipGuardian.
  ///
  /// In en, this message translates to:
  /// **'Guardian'**
  String get careRelationshipGuardian;

  /// No description provided for @careRelationshipCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Caregiver'**
  String get careRelationshipCaregiver;

  /// No description provided for @careRelationshipFriend.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get careRelationshipFriend;

  /// No description provided for @careRelationshipOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get careRelationshipOther;

  /// No description provided for @careInvitationOwner.
  ///
  /// In en, this message translates to:
  /// **'Invited by {name}'**
  String careInvitationOwner(String name);

  /// No description provided for @careRequestStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get careRequestStatusPending;

  /// No description provided for @careRequestStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get careRequestStatusApproved;

  /// No description provided for @careRequestStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get careRequestStatusRejected;

  /// No description provided for @careWatchedBy.
  ///
  /// In en, this message translates to:
  /// **'You can view {count} family member'**
  String careWatchedBy(int count);

  /// No description provided for @careWatchedByPlural.
  ///
  /// In en, this message translates to:
  /// **'You can view {count} family members'**
  String careWatchedByPlural(int count);

  /// No description provided for @careSharingTo.
  ///
  /// In en, this message translates to:
  /// **'Sharing with {count} approved member'**
  String careSharingTo(int count);

  /// No description provided for @careSharingToPlural.
  ///
  /// In en, this message translates to:
  /// **'Sharing with {count} approved members'**
  String careSharingToPlural(int count);

  /// No description provided for @careLocationSharing.
  ///
  /// In en, this message translates to:
  /// **'Location sharing'**
  String get careLocationSharing;

  /// No description provided for @careLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get careLoading;

  /// No description provided for @careRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get careRetry;

  /// No description provided for @careOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get careOpenSettings;

  /// No description provided for @careMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Connected since {date}'**
  String careMemberSince(String date);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
